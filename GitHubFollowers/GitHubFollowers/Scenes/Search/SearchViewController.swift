//
//  SearchViewController.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 15.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let logoImageView = UIImageView()
    let usernameTextField = CustomTextField()
    let searchButton = CustomButton()
    
    var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        logoImageView.image = Images.ghLogo
        
        searchButton.set(backgroundColor: .systemGreen, title: "Get Followers")
        searchButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

        usernameTextField.setPlaceholder("Enter a username")
        
        view.addSubviews(logoImageView, usernameTextField, searchButton)
        configureCostraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc private func didTapButton(_ sender: Any) {
        guard let userName = usernameTextField.text, !userName.isEmpty else {
            presentAlertOnMainThread(title: "Empty Username",
                                       message: "Please enter a username. We need to know who to look for 😃!",
                                       buttonTitle: "Ok")
            return
        }
    
        //TODO: prove that userName has valid characters.
        
        viewModel.inputs.enteredText(name: userName)
        viewModel.inputs.tappedSearchButton()
    }
    
    private func bind() {
        viewModel.outputs.didReceiveServiceError = { [weak self] error in
            guard let self = self else { return }
            self.presentAlertOnMainThread(title: "Service Error", message: error.localizedDescription, buttonTitle: "OK")
        }
        
        viewModel.outputs.reloadData = { [weak self] (followers) in
            self?.reloadData(followers)
        }
    }
    
    private func reloadData(_ followers: [Follower]) {
        print("user has \(followers.count) followers.")
        print(followers)
    }
}

// MARK: - UI Costraints

extension SearchViewController {
    private func configureCostraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                               constant: topConstraintConstant),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
