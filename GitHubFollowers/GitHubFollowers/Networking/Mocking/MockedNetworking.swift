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

func buildMockedService(data: Data, response: URLResponse = build200HttpResponse()) -> GitHubService {
    let gitHubMockedClient = GitHubClient(networking: mockNetworking(data: data, response: response))
    return gitHubMockedClient
}

func buildNoFollowers() -> [Follower] {
    return []
}

func buildThreeFollowers() -> [Follower] {
   let followers: [Follower] = [
        Follower(login: "user", avatarUrl: "https://url"),
        Follower(login: "user1", avatarUrl: "https://url"),
        Follower(login: "user2", avatarUrl: "https://url")
    ]
    return followers
}

func buildRandomFollowers(count: Int) -> [Follower] {
    var followers: [Follower] = []
    for index in 0..<count {
        followers.append(Follower(login: "user\(index)", avatarUrl: "https://url"))
    }
    return followers
}

func buildDataFor(followers: [Follower]) -> Data {
    let encoder = JSONEncoder()
    guard let data = try? encoder.encode(followers) else { fatalError("Cache directory not found! This should not happen!") }
    return data
}

func buildCorruptedData() -> Data {
    return Data()
}

func build400HttpResponse() -> URLResponse {
    let response = HTTPURLResponse(url: URL(string: "http://getFollowers")!, statusCode: 400, httpVersion: nil, headerFields: nil)!
    return response
}

func build200HttpResponse() -> URLResponse {
    let response = HTTPURLResponse(url: URL(string: "http://getFollowers")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    return response
}
