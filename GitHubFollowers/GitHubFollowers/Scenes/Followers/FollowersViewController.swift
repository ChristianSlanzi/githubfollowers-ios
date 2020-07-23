//
//  FollowersViewController.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 22.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

class FollowersViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    // MARK: - Viewcontroller Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    @objc func addButtonTapped() {
    }
}

