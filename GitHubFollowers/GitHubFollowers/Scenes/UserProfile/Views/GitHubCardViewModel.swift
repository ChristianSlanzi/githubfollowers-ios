//
//  GitHubCardViewModel.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 30.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol GitHubCardViewModelInputsType {
    func didTapGitHubButton()
}

protocol GitHubCardViewModelOutputsType: AnyObject {
    var showGitHubProfile: ((User) -> Void) { get set }
}

protocol GitHubCardViewModelType {
    var inputs: GitHubCardViewModelInputsType { get }
    var outputs: GitHubCardViewModelOutputsType { get }
}

class GitHubCardViewModel: GitHubCardViewModelType, GitHubCardViewModelInputsType, GitHubCardViewModelOutputsType {
    
    struct Input {
        //passing in data the viewModel needs from the view controller
        var user: User?
    }
    
    struct Output {
        let reposCountText: String
        let gistsCountText: String
    }
    
    private var input: Input
    public var output: Output
    
    init(input: Input) {
        self.input = input
        self.output = Output(
            reposCountText: "\(input.user?.publicRepos ?? 0)",
            gistsCountText: "\(input.user?.publicGists ?? 0)"
        )
    }
    
    public func setUser(_ user: User) {
        self.input.user = user
        self.output = Output(
            reposCountText: "\(input.user?.publicRepos ?? 0)",
            gistsCountText: "\(input.user?.publicGists ?? 0)"
        )
    }
    
    var inputs: GitHubCardViewModelInputsType { return self }
    var outputs: GitHubCardViewModelOutputsType { return self }
    
    //input
    func didTapGitHubButton() {
        guard let user = self.input.user else { return }
        self.showGitHubProfile(user)
    }
    
    //output
    var showGitHubProfile: ((User) -> Void) = { _ in }
}
