//
//  UserProfileViewModel.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 27.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol UserProfileViewModelInputsType {
    func viewDidLoad()
    func didTapGitHubProfileButton()
    func didTapGitFollowersButton()
}

protocol UserProfileViewModelOutputsType: AnyObject {
    var showGitHubProfile: (() -> Void) { get set }
    var showGitFollowers: (() -> Void) { get set }
}

protocol UserProfileViewModelType {
    var inputs: UserProfileViewModelInputsType { get }
    var outputs: UserProfileViewModelOutputsType { get }
}

class UserProfileViewModel: UserProfileViewModelType, UserProfileViewModelInputsType, UserProfileViewModelOutputsType {
    
    struct Input {
        //passing in data the viewModel needs from the view controller
        var user: User
    }
    
    struct Output {
        
    }
    
    private var input: Input
    
    init(input: Input) {
        self.input = input
    }
    
    var inputs: UserProfileViewModelInputsType { return self }
    var outputs: UserProfileViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
    }
    
    func didTapGitHubProfileButton() {
        
    }
    
    func didTapGitFollowersButton() {
        
    }
    
    //output
    public var showGitHubProfile: (() -> Void) = {  }
    public var showGitFollowers: (() -> Void) = {  }
    
    func getProfileViewModel() -> ProfileViewModel {
        return ProfileViewModel(
            input: ProfileViewModel.Input(user: input.user)
        )
    }
    
    func getGitHubCardViewModel() -> GitHubCardViewModel {
        return GitHubCardViewModel(input: GitHubCardViewModel.Input(user: input.user))
    }
}
