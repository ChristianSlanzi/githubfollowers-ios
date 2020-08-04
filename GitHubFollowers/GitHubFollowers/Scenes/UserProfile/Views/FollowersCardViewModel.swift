//
//  FollowersCardViewModel.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 30.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol FollowersCardViewModelInputsType {
    func didTapFollowersButton()
}

protocol FollowersCardViewModelOutputsType: AnyObject {
    var showFollowers: ((String) -> Void) { get set }
}

protocol FollowersCardViewModelType {
    var inputs: FollowersCardViewModelInputsType { get }
    var outputs: FollowersCardViewModelOutputsType { get }
}

class FollowersCardViewModel: FollowersCardViewModelType, FollowersCardViewModelInputsType, FollowersCardViewModelOutputsType {
    
    struct Input {
        //passing in data the viewModel needs from the view controller
        var user: User?
    }
    
    struct Output {
        let followersCountText: String
        let followingCountText: String
    }
    
    private var input: Input
    public var output: Output
    
    init(input: Input) {
        self.input = input
        self.output = Output(
            followersCountText: "\(input.user?.followers ?? 0)",
            followingCountText: "\(input.user?.following ?? 0)"
        )
    }
    
    public func setUser(_ user: User) {
        self.input.user = user
        self.output = Output(
            followersCountText: "\(input.user?.followers ?? 0)",
            followingCountText: "\(input.user?.following ?? 0)"
        )
    }
    
    var inputs: FollowersCardViewModelInputsType { return self }
    var outputs: FollowersCardViewModelOutputsType { return self }
    
    //input
    func didTapFollowersButton() {
        guard let user = self.input.user else { return }
        self.showFollowers(user.login)
    }
    
    //output
    var showFollowers: ((String) -> Void) = { _ in }
    
}
