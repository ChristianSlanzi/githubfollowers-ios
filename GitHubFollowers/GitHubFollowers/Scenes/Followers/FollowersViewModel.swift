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
    var reloadData: (() -> Void) { get set }
    var showUserProfile: ((String) -> Void) { get set }
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
        guard indexPath.row < followers.count else { return }
        let follower = followers[indexPath.item]
        self.showUserProfile(follower.login)
    }
    
    public func didSearchFor(_ filter: String) {
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        reloadData()
    }
    
    public func didResetSearch() {
        filteredFollowers.removeAll()
        reloadData()
        isSearching = false
    }
    
    // MARK: - Output
    //output
    public var didReceiveServiceError: ((Error) -> Void) = { _ in }
    
    public var reloadData: (() -> Void) = { }
    
    public var showUserProfile: ((String) -> Void) = { _ in }
    
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
                self.reloadData()
            case .failure(let error):
                // TODO: - handle different kinds of error. add specific error type
                self.didReceiveServiceError(error)
            }
        }
    }
}
