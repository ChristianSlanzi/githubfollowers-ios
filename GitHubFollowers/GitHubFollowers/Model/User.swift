//
//  User.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 18.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

public struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: Date
}
