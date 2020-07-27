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
    var didReceiveServiceError: ((Error) -> Void) { get set }
    var reloadData: (((String, [Follower])) -> Void) { get set }
}

protocol SearchViewModelType {
    var inputs: SearchViewModelInputsType { get }
    var outputs: SearchViewModelOutputsType { get }
}

// mvc or mvvm?
final class SearchViewModel: SearchViewModelType, SearchViewModelInputsType, SearchViewModelOutputsType {
    
    private let gitHubManager: GitHubNetworking

    struct Input {
        //passing in data the viewModel needs from the view controller
        var userName: String
    }
    
    struct Output {
        
    }
    
    private var input: Input
    
    init(input: Input, gitHubManager: GitHubNetworking) {
        self.input = input
        self.gitHubManager = gitHubManager
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
    public var didReceiveServiceError: ((Error) -> Void) = { _ in }
    
    typealias UserFollowers = (String, [Follower])
    public var reloadData: ((UserFollowers) -> Void) = { _ in }
    
    // public vars, methods
    public var isSearchTextEmpty: Bool { input.userName.isEmpty }
    
    public func isSearchTextEqualTo(_ searchText: String) -> Bool {
        input.userName == searchText
    }
    
    // MARK: - Helpers
    private func fetchFollowers() {
        guard !self.input.userName.isEmpty else { return }
        
        gitHubManager.fetchFollowers(for: self.input.userName, page: 1){ (result) in
            switch result {
            case .success(let followers):
                self.reloadData((self.input.userName, followers))
            case .failure(let error):
                self.didReceiveServiceError(error)
            }
        }
    }
}
