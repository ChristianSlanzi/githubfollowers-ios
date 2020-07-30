//
//  GitHubCardViewModel.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 30.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

struct GitHubCardViewModel {
    
    struct Input {
        //passing in data the viewModel needs from the view controller
        var user: User
    }
    
    struct Output {
        let reposCountText: String
        let gistsCountText: String
    }
    
    private var input: Input
    public let output: Output
    
    init(input: Input) {
        self.input = input
        self.output = Output(
            reposCountText: "\(input.user.publicRepos)",
            gistsCountText: "\(input.user.publicGists)"
        )
    }
}
