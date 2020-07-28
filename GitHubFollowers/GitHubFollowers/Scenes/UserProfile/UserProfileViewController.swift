//
//  UserProfileViewController.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 27.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    var viewModel: UserProfileViewModel
    
    
    let profileView = ProfileView()
    let githubCardView = GitHubCardView()
    let followersCardView = FollowersCardView()
    let dateLabel = UILabel()
    
    // MARK: - Viewcontroller Lifecycle
    
    init(viewModel: UserProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureUIElements()
        layoutUI()
    }
    
    // MARK: - MVVM Binding
    
    private func bind() {
        
    }
    
    func configureUIElements() {
        view.addSubview(profileView)
        view.addSubview(githubCardView)
        view.addSubview(followersCardView)
        view.addSubview(dateLabel)
    }
    
    private func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        // DEBUG
        profileView.backgroundColor = .yellow
        githubCardView.backgroundColor = .cyan
        followersCardView.backgroundColor = .systemPink
        
        dateLabel.textAlignment = .center
        dateLabel.text = "datum"

        for itemView in [profileView, githubCardView, followersCardView, dateLabel] {
            itemView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }

        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            profileView.heightAnchor.constraint(equalToConstant: 210),

            githubCardView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: padding),
            githubCardView.heightAnchor.constraint(equalToConstant: itemHeight),

            followersCardView.topAnchor.constraint(equalTo: githubCardView.bottomAnchor, constant: padding),
            followersCardView.heightAnchor.constraint(equalToConstant: itemHeight),

            dateLabel.topAnchor.constraint(equalTo: followersCardView.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])

    }
}
