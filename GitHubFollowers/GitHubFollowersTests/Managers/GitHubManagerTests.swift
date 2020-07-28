//
//  GitHubManagerTests.swift
//  GitHubFollowersTests
//
//  Created by Christian Slanzi on 27.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import XCTest
@testable import GitHubFollowers
import Combine

class GitHubManagerTests: XCTestCase {
    func testGetFollowersWithExpectedURLHostAndPath() {
        
        let sut = makeSut(networking: mockNetworking())
        let expectation = XCTestExpectation(description: "fetch github followers for user")

        
        sut.fetchFollowers(for: "user", page: 0) { (result) in
            // Make sure we downloaded some data.
            XCTAssertNotNil(result, "No data was downloaded.")
            expectation.fulfill()
        }

        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetFollowersEmptyData() {
        let response = HTTPURLResponse(url: URL(string: "http://getFollowers")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let sut = makeSut(networking: mockNetworking(response: response))
        let expectation = XCTestExpectation(description: "fetch github followers for user")
        
        sut.fetchFollowers(for: "user", page: 0) { (result) in
            // Make sure we downloaded some data.
            XCTAssertNotNil(result, "No data was downloaded.")
            
            
            switch result {
            case .success:
                XCTFail("No error thrown")
            case .failure(let error):
                XCTAssertTrue(error is DecodingError, "Unexpected error type: \(type(of: error))")
            }
            expectation.fulfill()
        }

        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetFollowersNoFollowers() {
        let emptyFollowers: [Follower] = []
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(emptyFollowers) else { return }
        let response = HTTPURLResponse(url: URL(string: "http://getFollowers")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let sut = makeSut(networking: mockNetworking(data: data, response: response))
        let expectation = XCTestExpectation(description: "fetch github followers for user")
        
        sut.fetchFollowers(for: "user", page: 0) { (result) in
            // Make sure we downloaded some data.
            XCTAssertNotNil(result, "No data was downloaded.")
            
            
            switch result {
            case .success(let followers):
                XCTAssertEqual(followers.count, 0)
            case .failure(let error):
                XCTFail("Unexpected error type: \(type(of: error))")
            }
            expectation.fulfill()
        }

        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetFollowersWithFollowers() {
        let followers: [Follower] = [
            Follower(login: "user", avatarUrl: "https://url"),
            Follower(login: "user1", avatarUrl: "https://url"),
            Follower(login: "user2", avatarUrl: "https://url")
        ]
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(followers) else { return }
        let response = HTTPURLResponse(url: URL(string: "http://getFollowers")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let sut = makeSut(networking: mockNetworking(data: data, response: response))
        let expectation = XCTestExpectation(description: "fetch github followers for user")
        
        sut.fetchFollowers(for: "user", page: 0) { (result) in
            // Make sure we downloaded some data.
            XCTAssertNotNil(result, "No data was downloaded.")
            
            
            switch result {
            case .success(let followers):
                XCTAssertEqual(followers.count, 3)
            case .failure(let error):
                XCTFail("Unexpected error type: \(type(of: error))")
            }
            expectation.fulfill()
        }

        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetUserInfoWithExpectedURLHostAndPath() {
        
        let sut = makeSut(networking: mockNetworking())
        let expectation = XCTestExpectation(description: "fetch info for user")

        
        sut.fetchUserInfo(for: "user") { (result) in
            // Make sure we downloaded some data.
            XCTAssertNotNil(result, "No data was downloaded.")
            expectation.fulfill()
        }

        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetUserInfoForExistingUser() {
        let user = User(login: "user",
                        avatarUrl: "http://",
                        name: "user name",
                        location: nil,
                        bio: nil,
                        publicRepos: 0,
                        publicGists: 0,
                        htmlUrl: "",
                        following: 0,
                        followers: 0,
                        createdAt: Date())
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601
        guard let data = try? encoder.encode(user) else { return }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        guard let userback = try? decoder.decode(User.self, from: data) else { return }
        print(userback)
        
        let response = HTTPURLResponse(url: URL(string: "http://getUserInfo")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let sut = makeSut(networking: mockNetworking(data: data, response: response))
        
        let expectation = XCTestExpectation(description: "fetch info for user")

        
        sut.fetchUserInfo(for: "user") { (result) in
            // Make sure we downloaded some data.
            XCTAssertNotNil(result, "No data was downloaded.")
        
            switch result {
                case .success(let user):
                    XCTAssertEqual(user.login, "user")
                case .failure(let error):
                    XCTFail("Unexpected error type: \(type(of: error))")
            }
            expectation.fulfill()
        }

        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 10.0)
    }
    
    // Helpers
    
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
    
    func makeSut(networking: @escaping Networking) -> GitHubManager {
        let mockedFeedService = GitHubClient(networking: networking)
        return GitHubManager(gitHubService: mockedFeedService)
    }
}
