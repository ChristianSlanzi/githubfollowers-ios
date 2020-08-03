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
        //sut.hasMoreFollowers = false
        let expectation = XCTestExpectation(description: "fetch github followers for user")
        
        sut.outputs.reloadData = { (followers) in
            XCTAssertEqual(followers.count, 3)
            XCTAssertFalse(sut.hasMoreFollowers)
            expectation.fulfill()
        }
        
        sut.inputs.viewDidLoad()
        
        // Wait until the expectation is fulfilled, with a timeout of 2 seconds.
        wait(for: [expectation], timeout: TIMEOUT_2_SECS)
    }
    
    func testLoad100FollowersWhenUserHasMoreFollowers() {
        let sut = makeSutWith103Followers(page: 1)
        //sut.followers = buildRandomFollowers(count: 100)
        sut.hasMoreFollowers = true
        let expectation = XCTestExpectation(description: "fetch more followers for user")
        
        sut.outputs.reloadData = { (followers) in
            XCTAssertEqual(followers.count, 100)
            expectation.fulfill()
        }
        
        sut.inputs.viewDidLoad()
        
        // Wait until the expectation is fulfilled, with a timeout of 2 seconds.
        wait(for: [expectation], timeout: TIMEOUT_2_SECS)
    }
    
    func testLoadMoreFollowersWhenUserHasMoreFollowersAndWeScrollOver() {
        let sut = makeSutWith103Followers(page: 2)
        //sut.followers = buildRandomFollowers(count: 100)
        sut.hasMoreFollowers = true
        let expectation = XCTestExpectation(description: "fetch more followers for user")
        
        sut.outputs.reloadData = { (followers) in
            XCTAssertEqual(followers.count, 103)
            expectation.fulfill()
        }
        
        sut.inputs.loadMoreFollowers()
        
        // Wait until the expectation is fulfilled, with a timeout of 2 seconds.
        wait(for: [expectation], timeout: TIMEOUT_2_SECS)
    }
    
    func testReturnErrorIfDataCorrupted() {
        let sut = makeSutWithCorruptedData()
        
        let expectation = XCTestExpectation(description: "fetch github followers for user")
        
        sut.outputs.didReceiveServiceError = { (error) in
            expectation.fulfill()
        }

        sut.viewDidLoad()
        
        // Wait until the expectation is fulfilled, with a timeout of 2 seconds.
        wait(for: [expectation], timeout: TIMEOUT_2_SECS)
    }
    
    func testFollowersNotFoundWhenUsernameNotEntered() {
        let sut = makeSutWith3Followers()
        
        let expectation = XCTestExpectation(description: "fetch github followers for user")
        expectation.isInverted = true
        
        sut.outputs.didReceiveServiceError = { (error) in
            expectation.fulfill()
        }

        sut.viewDidLoad()
        
        // Wait until the expectation is fulfilled, with a timeout of 2 seconds.
        wait(for: [expectation], timeout: TIMEOUT_2_SECS)
    }
    
    func testShowUserProfileWhenDidTapUserProfile() {
        let sut = makeSutWithUserProfile()
        
        let expectation = XCTestExpectation(description: "show User Profile")
        
        sut.showUserProfile = { (user) in
            expectation.fulfill()
        }

        sut.viewDidLoad()
        sut.didTapUserProfileAt(indexPath: IndexPath(row: 0, section: 0))
        
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
    
    private func makeSutWith103Followers(page: Int) -> FollowersViewModel {
        let input = FollowersViewModel.Input(userName: "user1")
        let total = 103
        let count = total < (100*page) ? total : (100*page)
        let data = buildDataFor(followers: buildRandomFollowers(count: count))
        let gitHubManager = GitHubManager(gitHubService: buildMockedService(data: data))
        let sut = FollowersViewModel(input: input, gitHubManager: gitHubManager)
        return sut
    }
    private func makeSutWithCorruptedData() -> FollowersViewModel {
        let input = FollowersViewModel.Input(userName: "user1")
        let data = buildCorruptedData()
        let gitHubManager = GitHubManager(gitHubService: buildMockedService(data: data, response: build400HttpResponse()))
        let sut = FollowersViewModel(input: input, gitHubManager: gitHubManager)
        return sut
    }
    
    private func makeSutWithUserProfile() -> FollowersViewModel {
        let input = FollowersViewModel.Input(userName: "user1")
        let data = buildUserProfileData()
        let gitHubManager = GitHubManager(gitHubService: buildMockedService(data: data))
        let sut = FollowersViewModel(input: input, gitHubManager: gitHubManager)
        sut.followers = [Follower(login: "user1", avatarUrl: "http://url")]
        return sut
    }
}
