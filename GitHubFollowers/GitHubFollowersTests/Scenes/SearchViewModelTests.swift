//
//  SearchViewModelTests.swift
//  GitHubFollowersTests
//
//  Created by Christian Slanzi on 21.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import XCTest
@testable import GitHubFollowers

class SearchViewModelTests: XCTestCase {
    
    let TIMEOUT_2_SECS = 2.0

    func testViewDidLoad_userNameIsEmpty() {
        //given
        let sut = makeSut()
        //when
        sut.inputs.viewDidLoad()
        //then
        XCTAssertEqual(sut.isSearchTextEmpty, true)
    }
    
    func testTextEntered_userNameIsNotEmpty() {
        //given
        let sut = makeSut()
        //when
        sut.inputs.enteredText(name: "text")
        //then
        XCTAssertEqual(sut.isSearchTextEmpty, false)
    }
    
    func testUsernameIsEqualTextEntered() {
       //given
        let sut = makeSut()
        let searchText = "text"
        //when
        sut.inputs.enteredText(name: searchText)
        //then
        XCTAssertEqual(sut.isSearchTextEqualTo(searchText), true)
    }
    
    func testFollowersFoundForUserWhenSearchButtonTapped() {
        let sut = makeSutWith3Followers()
        let searchText = "user1"
        
        let expectation = XCTestExpectation(description: "fetch github followers for user")
        
        sut.inputs.enteredText(name: searchText)
        sut.outputs.showFollowers = { (result) in
            let (user, followers) = result
            XCTAssertEqual(user, searchText)
            XCTAssertEqual(followers.count, 3)
            expectation.fulfill()
        }

        sut.didTapSearchButton()
        
        // Wait until the expectation is fulfilled, with a timeout of 2 seconds.
        wait(for: [expectation], timeout: TIMEOUT_2_SECS)
    }
    
    func testFollowersFoundForUserWhenKeyReturned() {
        let sut = makeSutWith3Followers()
        let searchText = "user1"
        
        let expectation = XCTestExpectation(description: "fetch github followers for user")
        
        sut.inputs.enteredText(name: searchText)
        sut.outputs.showFollowers = { (result) in
            let (user, followers) = result
            XCTAssertEqual(user, searchText)
            XCTAssertEqual(followers.count, 3)
            expectation.fulfill()
        }

        sut.textFieldReturned()
        
        // Wait until the expectation is fulfilled, with a timeout of 2 seconds.
        wait(for: [expectation], timeout: TIMEOUT_2_SECS)
    }
    
    
    
    func testFollowersNotFoundWhenSearchButtonTappedAndUsernameNotEntered() {
        let sut = makeSutWith3Followers()
        let searchText = ""
        
        let expectation = XCTestExpectation(description: "fetch github followers for user")
        expectation.isInverted = true
        
        sut.inputs.enteredText(name: searchText)
        sut.outputs.showFollowers = { (result) in
            expectation.fulfill()
        }

        sut.didTapSearchButton()
        
        // Wait until the expectation is fulfilled, with a timeout of 2 seconds.
        wait(for: [expectation], timeout: TIMEOUT_2_SECS)
    }
    
    func testReturnErrorIfDataCorrupted() {
        let sut = makeSutWithCorruptedData()
        let searchText = "userCorrupted"
        
        let expectation = XCTestExpectation(description: "fetch github followers for user")
        
        sut.inputs.enteredText(name: searchText)
        sut.outputs.didReceiveServiceError = { (error) in
            expectation.fulfill()
        }

        sut.didTapSearchButton()
        
        // Wait until the expectation is fulfilled, with a timeout of 2 seconds.
        wait(for: [expectation], timeout: TIMEOUT_2_SECS)
    }
    
    // MARK: - Helpers:
    
    private func makeSut() -> SearchViewModel {
        let input = SearchViewModel.Input(userName: "")
        let gitHubClient = GitHubClient(networking: URLSession.shared.erasedDataTaskPublisher)
        let gitHubManager = GitHubManager(gitHubService: gitHubClient)
        let sut = SearchViewModel(input: input, gitHubManager: gitHubManager)
        return sut
    }
    
    private func makeSutWith3Followers() -> SearchViewModel {
        let input = SearchViewModel.Input(userName: "")
        let data = buildDataFor(followers: buildThreeFollowers())
        let gitHubManager = GitHubManager(gitHubService: buildMockedService(data: data))
        let sut = SearchViewModel(input: input, gitHubManager: gitHubManager)
        return sut
    }
    
    private func makeSutWithCorruptedData() -> SearchViewModel {
        let input = SearchViewModel.Input(userName: "")
        let data = buildCorruptedData()
        let gitHubManager = GitHubManager(gitHubService: buildMockedService(data: data, response: build400HttpResponse()))
        let sut = SearchViewModel(input: input, gitHubManager: gitHubManager)
        return sut
    }

}

