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
