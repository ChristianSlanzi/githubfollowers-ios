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
    }
    
    // MARK: - MVVM Binding
    
    private func bind() {
        
    }
}
