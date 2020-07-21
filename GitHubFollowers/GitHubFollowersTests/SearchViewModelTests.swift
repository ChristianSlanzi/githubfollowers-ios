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

    func testViewDidLoad_userNameIsEmpty() {
        //given
        let sut = makeSut()
        //when
        sut.viewDidLoad()
        //then
        XCTAssertEqual(sut.isSearchTextEmpty, true)
    }
    
    func testTextEntered_userNameIsNotEmpty() {
        //given
        let sut = makeSut()
        //when
        sut.enteredText(name: "text")
        //then
        XCTAssertEqual(sut.isSearchTextEmpty, false)
    }
    
    func testUsernameIsEqualTextEntered() {
       //given
        let sut = makeSut()
        let searchText = "text"
        //when
        sut.enteredText(name: searchText)
        //then
        XCTAssertEqual(sut.isSearchTextEqualTo(searchText), true)
    }
    
    // Helpers:
    private func makeSut() -> SearchViewModel {
        let input = SearchViewModel.Input(userName: "")
        let gitHubClient = GitHubClient(networking: URLSession.shared.erasedDataTaskPublisher)
        let gitHubManager = GitHubManager(gitHubService: gitHubClient)
        let sut = SearchViewModel(input: input, gitHubManager: gitHubManager)
        return sut
    }

}

