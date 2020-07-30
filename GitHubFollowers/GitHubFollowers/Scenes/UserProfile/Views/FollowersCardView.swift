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
    var viewModel: FollowersCardViewModel
    
    init(viewModel: FollowersCardViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        bind()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup

    internal override func setupViews() {
        super.setupViews()
        actionButton.setTitle("Git Followers", for: .normal)
        actionButton.backgroundColor = .systemGreen
    }
    
    // MARK: - MVVM Binding
    
    private func bind() {
        itemInfoViewOne.set(itemInfoType: .followers, withCountText: viewModel.output.followersCountText)
        itemInfoViewTwo.set(itemInfoType: .following, withCountText: viewModel.output.followingCountText)
    }
}
