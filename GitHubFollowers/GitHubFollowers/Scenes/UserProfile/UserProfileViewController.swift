//
//  UserProfileViewController.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 27.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit
import Utils

class UserProfileViewController: UIViewController {
    
    var viewModel: UserProfileViewModel
    
    var flowDelegate: AppFlowControllerDelegate?

    let profileView: ProfileView
    let githubCardView: GitHubCardView
    let followersCardView: FollowersCardView
    let dateLabel = UILabel()
    
    // MARK: - Viewcontroller Lifecycle
    
    init(viewModel: UserProfileViewModel) {
        self.viewModel = viewModel
        self.profileView = ProfileView(viewModel: viewModel.getProfileViewModel())
        self.githubCardView = GitHubCardView(viewModel: viewModel.getGitHubCardViewModel())
        self.followersCardView = FollowersCardView(viewModel: viewModel.getFollowersCardViewModel())
    
        super.init(nibName: nil, bundle: nil)
        
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupViews()
        setupConstraints()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        //collectionView.showLoadingView()
    }
    
    // MARK: - MVVM Binding
    
    private func bind() {
        viewModel.outputs.reloadData = {
            DispatchQueue.main.async {
                self.profileView.reload()
                self.githubCardView.reload()
                self.followersCardView.reload()
                guard let date = self.viewModel.getUserCreatedAt() else { return }
                self.dateLabel.text = " GitHub since \(date.toMonthYearString())"
            }
        }
        
        viewModel.outputs.didReceiveServiceError = { [weak self] error in
            guard let self = self else { return }
            self.presentAlertOnMainThread(title: "Service Error", message: error.localizedDescription, buttonTitle: "OK")
        }
        
        viewModel.showAddToFavoritesResult = { error in
            guard let error = error else {
                let title = "Success"
                let message = "You have successfully favorited this user 🎉"
                self.presentAlertOnMainThread(title: title, message: message, buttonTitle: "Hooray!")
                return
            }
            
            let title = "Something went wrong."
            let message = error.rawValue
            self.presentAlertOnMainThread(title: title, message: message, buttonTitle: "OK")
        }
    }
    
    private func setupViews() {
        view.addSubview(profileView)
        view.addSubview(githubCardView)
        view.addSubview(followersCardView)
        view.addSubview(dateLabel)
        
        self.githubCardView.flowDelegate = flowDelegate
        self.followersCardView.flowDelegate = flowDelegate
        
        // DEBUG
        //profileView.backgroundColor = .yellow
        //githubCardView.backgroundColor = .cyan
        //followersCardView.backgroundColor = .systemPink
        
        dateLabel.textAlignment = .center
        dateLabel.text = ""
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
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
    
    @objc func addButtonTapped() {
        viewModel.didTapAddToFavoriteButton()
    }
}
