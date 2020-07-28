//
//  MockedNetworking.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 27.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import Combine

func mockNetworking(
    data: Data = .init(),
    response: URLResponse = .init()
) -> Networking {
    return { _ in
        Just((data: data, response: response))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

func buildMockedService() -> GitHubService {
    let followers: [Follower] = [
        Follower(login: "user", avatarUrl: "https://url"),
        Follower(login: "user1", avatarUrl: "https://url"),
        Follower(login: "user2", avatarUrl: "https://url")
    ]
    let encoder = JSONEncoder()
    guard let data = try? encoder.encode(followers) else { fatalError("Cache directory not found! This should not happen!") }
    let response = HTTPURLResponse(url: URL(string: "http://getFollowers")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    let gitHubMockedClient = GitHubClient(networking: mockNetworking(data: data, response: response))
    return gitHubMockedClient
}
