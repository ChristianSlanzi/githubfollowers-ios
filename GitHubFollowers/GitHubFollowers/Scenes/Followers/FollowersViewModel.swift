//
//  FollowersViewModel.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 22.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol FollowersViewModelInputsType {
    func viewDidLoad()
    func loadMoreFollowers()
    func didTapUserProfileAt(indexPath: IndexPath)
    func didSearchFor(_ filter: String)
}

protocol FollowersViewModelOutputsType: AnyObject {
    var didReceiveServiceError: ((Error) -> Void) { get set }
    var reloadData: (([Follower]) -> Void) { get set }
    var showUserProfile: ((User) -> Void) { get set }
}

protocol FollowersViewModelType {
    var inputs: FollowersViewModelInputsType { get }
    var outputs: FollowersViewModelOutputsType { get }
}

final class FollowersViewModel: FollowersViewModelType, FollowersViewModelInputsType, FollowersViewModelOutputsType {
    
    private let gitHubManager: GitHubNetworking
    
    struct Input {
        //passing in data the viewModel needs from the view controller
        var userName: String
    }
    
    struct Output {
        
    }

    // MARK: properties
    var inputs: FollowersViewModelInputsType { return self }
    var outputs: FollowersViewModelOutputsType { return self }

    
    private var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    var isLoadingMoreFollowers = false
    
    public func getFollowersCount() -> Int {
        return isSearching ? filteredFollowers.count : followers.count
    }
    
    public func getFollower(_ indexPath: IndexPath) -> Follower {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        return follower
    }
    
    private var input: Input
    
    init(input: Input, gitHubManager: GitHubNetworking) {
        self.input = input
        self.gitHubManager = gitHubManager
    }
    
    // MARK: - Input
    public func viewDidLoad() {
        fetchFollowers()
    }
    
    public func loadMoreFollowers() {
        fetchFollowers()
    }
    
    public func didTapUserProfileAt(indexPath: IndexPath) {
        let follower = followers[indexPath.item]
        gitHubManager.fetchUserInfo(for: follower.login) { (result) in
            switch result {
            case .success(let user):
                self.showUserProfile(user)
                break
            case .failure(let error):
                self.didReceiveServiceError(error)
            }
        }
    }
    
    public func didSearchFor(_ filter: String) {
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        //updateData(on: viewModel.filteredFollowers)
        reloadData(filteredFollowers)
    }
    
    // MARK: - Output
    //output
    public var didReceiveServiceError: ((Error) -> Void) = { _ in }
    
    public var reloadData: (([Follower]) -> Void) = { _ in }
    
    public var showUserProfile: ((User) -> Void) = { _ in }
    
    // MARK: - Helpers
    private func fetchFollowers() {
        guard !self.input.userName.isEmpty else { return }
        
        isLoadingMoreFollowers = true
        gitHubManager.fetchFollowers(for: self.input.userName, page: page){ (result) in
            self.isLoadingMoreFollowers = false
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                self.reloadData(followers)
            case .failure(let error):
                self.didReceiveServiceError(error)
            }
        }
    }
}
