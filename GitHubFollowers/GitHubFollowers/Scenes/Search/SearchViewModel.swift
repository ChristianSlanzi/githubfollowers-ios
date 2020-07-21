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
    func tappedSearchButton()
}
protocol SearchViewModelOutputsType: class {
    var didReceiveServiceError: ((Error) -> Void) { get set }
    var reloadData: (([Follower]) -> Void) { get set }
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
    func viewDidLoad() {
        
    }
    
    func enteredText(name: String) {
        self.input.userName = name
    }
    
    func tappedSearchButton() {
        gitHubManager.fetchFollowers(for: self.input.userName, page: 0){ (result) in
            switch result {
            case .success(let followers):
                self.reloadData(followers)
            case .failure(let error):
                self.didReceiveServiceError(error)
            }
        }
    }
    
    //output
    var didReceiveServiceError: ((Error) -> Void) = { _ in }
    
    var reloadData: (([Follower]) -> Void) = { _ in }
    
}
