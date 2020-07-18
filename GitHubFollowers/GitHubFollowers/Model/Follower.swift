//
//  Follower.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 18.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

public struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
}
