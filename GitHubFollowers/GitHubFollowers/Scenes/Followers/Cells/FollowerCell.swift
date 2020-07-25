//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 24.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    // MARK: - Properties

    static let reuseID = "FollowerCell"
    
    let profileImageView = UIImageView(frame: .zero)
    let usernameLabel = UILabel(frame: .zero)

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    /// init required by the API to support storyboards
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(viewModel: Follower) {
        //profileImageView.downloadImage(fromURL: viewModel.avatarUrl)
        profileImageView.image = UIImage(named: "AppIcon")
        usernameLabel.text = viewModel.login
    }
    
    // MARK: - Layout Methods

    private func configure() {
        backgroundColor = .systemBackground
        addSubviews(profileImageView, usernameLabel)
        
        let padding: CGFloat = 8
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            profileImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
