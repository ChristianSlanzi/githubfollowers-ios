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
    var showProfileForUsername: ((String) -> Void) { get set }
}

protocol SearchViewModelType {
    var inputs: SearchViewModelInputsType { get }
    var outputs: SearchViewModelOutputsType { get }
}

final class SearchViewModel: SearchViewModelType, SearchViewModelInputsType, SearchViewModelOutputsType {
    
    struct Input {
        //passing in data the viewModel needs from the view controller
        var username: String
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
        self.input.username = ""
    }
    
    public func enteredText(name: String) {
        self.input.username = name
    }
    
    public func textFieldReturned() {
        validateUsernameAndCallOutputCallback()
    }
    
    public func didTapSearchButton() {
        validateUsernameAndCallOutputCallback()
    }

    //output
    public var showProfileForUsername: ((String) -> Void) = { _ in }
    
    // public vars, methods
    public var isSearchTextEmpty: Bool { input.username.isEmpty }
    
    public func isSearchTextEqualTo(_ searchText: String) -> Bool {
        input.username == searchText
    }
    
    // MARK: - Helpers
    
    private func validateUsernameAndCallOutputCallback() {
        guard !isSearchTextEmpty else { return }
        self.showProfileForUsername(self.input.username)
    }
}
