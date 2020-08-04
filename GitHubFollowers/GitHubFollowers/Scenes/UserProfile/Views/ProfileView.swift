//
//  ProfileView.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 28.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    // MARK: - Properties
    var viewModel: ProfileViewModel

    let profileImageView = CachedImageView(frame: .zero)
    let usernameLabel = UILabel()
    let nameLabel = UILabel()
    let locationImageView = UIImageView()
    let locationLabel = UILabel()
    let bioLabel = UILabel()
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupViews()
        setupCostraints()
        bind()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - MVVM Binding
    
    private func bind() {
        //let user = User(login: "user", avatarUrl: "http://avatarUrl", name: nil, location: nil, bio: nil, publicRepos: 0, publicGists: 0, htmlUrl: "", following: 0, followers: 0, createdAt: Date())
        
        
    }
    
    func reload() {
        profileImageView.load(url: URL(string: viewModel.getAvatarUrl())!)
        usernameLabel.text = viewModel.getUsername()
        nameLabel.text = viewModel.getName()
        locationLabel.text = viewModel.getLocation()
        bioLabel.text = viewModel.getBio()
        
    }
    
    private func setupViews() {
        backgroundColor = .systemBackground
        
        //locationImageView.image = SFSymbols.location
        locationImageView.tintColor = .secondaryLabel
        
        bioLabel.numberOfLines = 3
        
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(nameLabel)
        addSubview(locationImageView)
        addSubview(locationLabel)
        addSubview(bioLabel)
    }
    
    private func setupCostraints() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12

        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 90),
            profileImageView.heightAnchor.constraint(equalToConstant: 90),

            usernameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),

            nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),

            locationImageView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor,
                                                       constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),

            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),

            bioLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 90)
        ])

    }
    
}
