//
//  ProfileViewModel.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 28.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

struct ProfileViewModel {

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
    
    public func getUsername() -> String {
        return input.user.login
    }
    public func getName() -> String {
        return input.user.name ?? "No name"
    }
    public func getAvatarUrl() -> String {
        return input.user.avatarUrl
    }
    public func getLocation() -> String {
        return input.user.location ?? "No Location"
    }
    public func getBio() -> String {
        return input.user.bio ?? "No Bio Available"
    }
}
