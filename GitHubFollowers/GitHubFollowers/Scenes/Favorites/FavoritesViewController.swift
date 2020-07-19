//
//  FavoritesViewController.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 15.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    private let gitHubManager: GitHubNetworking
    
    init(gitHubManager: GitHubNetworking) {
        self.gitHubManager = gitHubManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        gitHubManager.fetchUserInfo(for: "cardoso") { (userInfo) in
            print(userInfo)
        }
    }
}
