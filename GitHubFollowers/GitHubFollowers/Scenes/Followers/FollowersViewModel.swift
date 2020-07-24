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

final class FollowersViewModel {
    
    // MARK: properties

    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    var isLoadingMoreFollowers = false
}
