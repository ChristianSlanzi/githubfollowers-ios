//
//  FollowersCardView.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 28.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

class FollowersCardView: CardView {
    
    // MARK: - Properties
    
    // MARK: - Setup

    internal override func setupViews() {
        super.setupViews()
        itemInfoViewOne.set(itemInfoType: .followers, withCountText: "0")
        itemInfoViewTwo.set(itemInfoType: .following, withCountText: "0")
        actionButton.setTitle("Git Followers", for: .normal)
        actionButton.backgroundColor = .systemGreen
    }
}
