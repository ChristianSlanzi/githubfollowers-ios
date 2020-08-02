//
//  FavoritesCell.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 02.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

class FavoritesCell: UITableViewCell {
    static let reuseID = "FollowerCell"
    
    let profileImageView = CachedImageView(frame: .zero)
    let usernameLabel = UILabel(frame: .zero)
    
    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    /// init required by the API to support storyboards
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Methods

    /// call from cellForRowAtIndexPath to set this cell's properties
    func set(favorite: Follower) {
        profileImageView.load(url: URL(string: favorite.avatarUrl)!)
        usernameLabel.text = favorite.login
    }

    private func configure() {
        addSubviews(profileImageView, usernameLabel)

        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            profileImageView.heightAnchor.constraint(equalToConstant: 60),
            profileImageView.widthAnchor.constraint(equalToConstant: 60),

            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)

        ])
    }
}
