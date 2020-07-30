//
//  GitHubCardView.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 28.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

class GitHubCardView: CardView {
    
    // MARK: - Properties
    
    // MARK: - Setup

    internal override func setupViews() {
        super.setupViews()
        itemInfoViewOne.set(itemInfoType: .repos, withCount: 0)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: 0)
        actionButton.setTitle("GitHub Profile", for: .normal)
        actionButton.backgroundColor = .purple
    }
}
