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
        var user: User
    }
    
    struct Output {
        let followersCountText: String
        let followingCountText: String
    }
    
    private var input: Input
    public let output: Output
    
    init(input: Input) {
        self.input = input
        self.output = Output(
            followersCountText: "\(input.user.followers)",
            followingCountText: "\(input.user.following)"
        )
    }
    
    var inputs: FollowersCardViewModelInputsType { return self }
    var outputs: FollowersCardViewModelOutputsType { return self }
    
    //input
    func didTapFollowersButton() {
        self.showFollowers(self.input.user.login)
    }
    
    //output
    var showFollowers: ((String) -> Void) = { _ in }
    
}
