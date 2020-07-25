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
}

protocol FollowersViewModelOutputsType: AnyObject {
    var didReceiveServiceError: ((Error) -> Void) { get set }
    var reloadData: (([Follower]) -> Void) { get set }
}

protocol FollowersViewModelType {
    var inputs: FollowersViewModelInputsType { get }
    var outputs: FollowersViewModelOutputsType { get }
}

final class FollowersViewModel: FollowersViewModelType, FollowersViewModelInputsType, FollowersViewModelOutputsType {
    
    struct Input {
        //passing in data the viewModel needs from the view controller
        
    }
    
    struct Output {
        
    }

    // MARK: properties
    var inputs: FollowersViewModelInputsType { return self }
    var outputs: FollowersViewModelOutputsType { return self }

    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    var isLoadingMoreFollowers = false
    
    // MARK: - Input
    public func viewDidLoad() {
        self.reloadData(followers)
    }
    
    public func loadMoreFollowers() {
        
    }
    
    // MARK: - Output
    //output
    public var didReceiveServiceError: ((Error) -> Void) = { _ in }
    
    public var reloadData: (([Follower]) -> Void) = { _ in }
}
