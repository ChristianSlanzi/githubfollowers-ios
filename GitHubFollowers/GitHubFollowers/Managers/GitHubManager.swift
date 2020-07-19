//
//  GitHubManager.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 19.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import Combine

public protocol GitHubNetworking {
    func fetchFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], Error>) -> Void)
    func fetchUserInfo(for username: String, completion: @escaping (Result<User, Error>) -> Void)
}

/// GitHubManager uses the service, has persistence... caching...

class GitHubManager: GitHubNetworking {
    
    var gitHubService: GitHubService
    var subscription: AnyCancellable?
    
    init(gitHubService: GitHubService) {
        self.gitHubService = gitHubService
    }
    
    func fetchFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], Error>) -> Void) {
        subscription = gitHubService.fetchFollowers(for: username, page: 0).sink(receiveCompletion: { completion in
           print(completion)
        }) { (followers) in
            completion(.success(followers))
        }
    }
    
    func fetchUserInfo(for username: String, completion: @escaping (Result<User, Error>) -> Void) {
        subscription = gitHubService.fetchUserInfo(for: username).sink(receiveCompletion: { completion in
           print(completion)
        }) { (userInfo) in
            completion(.success(userInfo))
        }
    }
    
}

