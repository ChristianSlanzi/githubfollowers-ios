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
        sut.textFieldReturned()
        //then
        XCTAssertEqual(sut.isSearchTextEqualTo(searchText), true)
    }
    
    func testUsernameWhenSearchButtonTapped() {
        let sut = makeSut()
        let searchText = "user1"
        
        let expectation = XCTestExpectation(description: "fetch github followers for user")
        
        sut.inputs.enteredText(name: searchText)
        sut.outputs.showProfileForUsername = { (username) in
            //let (user, followers) = result
            XCTAssertEqual(username, searchText)
            //XCTAssertEqual(followers.count, 3)
            expectation.fulfill()
        }

        sut.didTapSearchButton()
        
        // Wait until the expectation is fulfilled, with a timeout of 2 seconds.
        wait(for: [expectation], timeout: TIMEOUT_2_SECS)
    }
    
    // MARK: - Helpers:
    
    private func makeSut() -> SearchViewModel {
        let input = SearchViewModel.Input(userName: "")
        let sut = SearchViewModel(input: input)
        return sut
    }
}

