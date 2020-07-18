//
//  GitHubService.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 18.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import Combine

public protocol GitHubService {
    func fetchFollowers(for username: String, page: Int) -> AnyPublisher<[Follower], Error>
    func fetchUserInfo(for username: String) -> AnyPublisher<User, Error>
}

struct GitHubClient: GitHubService {
    let networking: Networking
    
    func fetchFollowers(for username: String, page: Int) -> AnyPublisher<[Follower], Error> {
        networking(.getFollowers(for: username, page: page))
        .map { $0.data }
        .decode(type: [Follower].self, decoder: makeJSONDecoder())
        .eraseToAnyPublisher()
    }
    
    func fetchUserInfo(for username: String) -> AnyPublisher<User, Error> {
        networking(.getUserInfo(for: username))
        .map { $0.data }
        .decode(type: User.self, decoder: makeJSONDecoder())
        .eraseToAnyPublisher()
    }
    
    private func makeJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}

// Helpers
private let baseURL = "https://api.github.com/users/"

private extension URLRequest {
    static func getFollowers(for username: String, page: Int) -> URLRequest {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        return URLRequest(url: URL(string: endpoint)!)
    }
    static func getUserInfo(for username: String) -> URLRequest {
        let endpoint = baseURL + "\(username)"
        return URLRequest(url: URL(string: endpoint)!)
    }
}
