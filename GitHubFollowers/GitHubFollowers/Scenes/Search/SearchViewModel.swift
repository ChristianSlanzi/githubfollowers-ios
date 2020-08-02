//
//  SearchViewModel.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 21.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol SearchViewModelInputsType {
    func viewDidLoad()
    func enteredText(name: String)
    func textFieldReturned()
    func didTapSearchButton()
}
protocol SearchViewModelOutputsType: AnyObject {
    var showFollowersForUsername: ((String) -> Void) { get set }
}

protocol SearchViewModelType {
    var inputs: SearchViewModelInputsType { get }
    var outputs: SearchViewModelOutputsType { get }
}

// mvc or mvvm?
final class SearchViewModel: SearchViewModelType, SearchViewModelInputsType, SearchViewModelOutputsType {
    
    struct Input {
        //passing in data the viewModel needs from the view controller
        var userName: String
    }
    
    struct Output {
        
    }
    
    private var input: Input
    
    init(input: Input) {
        self.input = input
    }
    
    var inputs: SearchViewModelInputsType { return self }
    var outputs: SearchViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
        self.input.userName = ""
    }
    
    public func enteredText(name: String) {
        self.input.userName = name
    }
    
    public func textFieldReturned() {
        fetchFollowers()
    }
    
    public func didTapSearchButton() {
        fetchFollowers()
    }

    //output
    public var showFollowersForUsername: ((String) -> Void) = { _ in }
    
    // public vars, methods
    public var isSearchTextEmpty: Bool { input.userName.isEmpty }
    
    public func isSearchTextEqualTo(_ searchText: String) -> Bool {
        input.userName == searchText
    }
    
    // MARK: - Helpers
    
    private func fetchFollowers() {
        guard !isSearchTextEmpty else { return }
        
        self.showFollowersForUsername(self.input.userName)
    }
}
