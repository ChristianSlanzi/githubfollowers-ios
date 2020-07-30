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
    var viewModel: GitHubCardViewModel
    
    init(viewModel: GitHubCardViewModel) {
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
        
        actionButton.setTitle("GitHub Profile", for: .normal)
        actionButton.backgroundColor = .purple
    }
    
    // MARK: - MVVM Binding
    
    private func bind() {
        itemInfoViewOne.set(itemInfoType: .repos, withCountText: viewModel.output.reposCountText)
        itemInfoViewTwo.set(itemInfoType: .gists, withCountText: viewModel.output.gistsCountText)
    }
}
