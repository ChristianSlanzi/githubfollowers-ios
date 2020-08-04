//
//  UserProfileViewModelTests.swift
//  GitHubFollowersTests
//
//  Created by Christian Slanzi on 03.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import XCTest
@testable import GitHubFollowers

class UserProfileViewModelTests: XCTestCase {
    
    let TIMEOUT_2_SECS = 2.0
    
    func testCallbackWasCalledWhendidTapAddToFavoriteButton() {
        let sut = makeSut()
        
        let expectation = XCTestExpectation(description: "didTapAddToFavorite")
        
        sut.showAddToFavoritesResult = { (error) in
            expectation.fulfill()
        }

        sut.viewDidLoad()
        sut.didTapAddToFavoriteButton()
        
        // Wait until the expectation is fulfilled, with a timeout of 2 seconds.
        wait(for: [expectation], timeout: TIMEOUT_2_SECS)
    }
    // MARK: - Helpers:
    
    private func makeSut() -> UserProfileViewModel {
        let user = User(login: "user"+String(describing: Int.random(in: 0 ..< 10)), avatarUrl: "htpps://url", name: nil, location: nil, bio: nil, publicRepos: 0, publicGists: 0, htmlUrl: "", following: 0, followers: 0, createdAt: Date())
        let input = UserProfileViewModel.Input(username: user.login)
        let data = buildUserProfileData()
        let gitHubManager = GitHubManager(gitHubService: buildMockedService(data: data))
        let sut = UserProfileViewModel(input: input, gitHubManager: gitHubManager)
        return sut
    }
    
}
