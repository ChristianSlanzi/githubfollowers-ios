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

    
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    var isLoadingMoreFollowers = false
    
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
    
    // MARK: - Output
    //output
    public var didReceiveServiceError: ((Error) -> Void) = { _ in }
    
    public var reloadData: (([Follower]) -> Void) = { _ in }
    
    public var showUserProfile: ((User) -> Void) = { _ in }
    
    // MARK: - Helpers
    private func fetchFollowers() {
        guard !self.input.userName.isEmpty else { return }
        
        gitHubManager.fetchFollowers(for: self.input.userName, page: page){ (result) in
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
