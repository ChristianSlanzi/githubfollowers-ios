//
//  ItemInfoView.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 29.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

class ItemInfoView: UIView {
    
    // MARK: - Properties

    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let countLabel = UILabel()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupCostraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Methods

    private func setupViews() {
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.tintColor = .label
        
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        countLabel.textAlignment = .center
        countLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        addSubviews(iconImageView, titleLabel, countLabel)
    }
    
    private func setupCostraints() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),

            titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),

            countLabel.centerYAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)

        ])
    }
}

extension ItemInfoView {
    enum ItemInfoType {
        case repos, gists, followers, following
    }
    
    func set(itemInfoType: ItemInfoType, withCountText count: String) {
        switch itemInfoType {
        case .repos:
            iconImageView.image = SFSymbols.repos
            titleLabel.text = "Public Repos"
        case .gists:
            iconImageView.image = SFSymbols.gists
            titleLabel.text = "Public Gists"
        case .followers:
            iconImageView.image = SFSymbols.followers
            titleLabel.text = "Followers"
        case .following:
            iconImageView.image = SFSymbols.following
            titleLabel.text = "Following"
        }

        countLabel.text = count
    }
}
