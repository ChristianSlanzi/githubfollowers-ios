//
//  FollowersViewModelTests.swift
//  GitHubFollowersTests
//
//  Created by Christian Slanzi on 28.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

import XCTest
@testable import GitHubFollowers

class FollowersViewModelTests: XCTestCase {
    
    let TIMEOUT_2_SECS = 2.0

    func testFollowersFoundWhenViewLoaded() {
        let sut = makeSutWith3Followers()
        sut.followers = buildThreeFollowers()
        let expectation = XCTestExpectation(description: "fetch github followers for user")
        
        sut.reloadData = { (followers) in
            XCTAssertEqual(followers.count, 3)
            expectation.fulfill()
        }
        
        sut.viewDidLoad()
        
        // Wait until the expectation is fulfilled, with a timeout of 2 seconds.
        wait(for: [expectation], timeout: TIMEOUT_2_SECS)
    }
    
    // MARK: - Helpers
    
    private func makeSutWith3Followers() -> FollowersViewModel {
        let input = FollowersViewModel.Input(userName: "user1")
        let data = buildDataFor(followers: buildThreeFollowers())
        let gitHubManager = GitHubManager(gitHubService: buildMockedService(data: data))
        let sut = FollowersViewModel(input: input, gitHubManager: gitHubManager)
        return sut
    }
}
