//
//  AppFlowViewController.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 15.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

class AppFlowViewController: UIViewController {
    private let tabController = UITabBarController()
    private let gitHubService: GitHubService
    
    init(gitHubService: GitHubService) {
        self.gitHubService = gitHubService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabController.viewControllers = [createSearchNavigationController(),
                                         createFavoritesListNavigationController()]
        add(tabController)
    }
    
    private func createSearchNavigationController() -> UIViewController {
        let productsFlowVC = SearchViewController(gitHubService: gitHubService)
        productsFlowVC.title = "Search"
        productsFlowVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return productsFlowVC
    }
    
    private func createFavoritesListNavigationController() -> UIViewController {
        let productDetailsFlowVC = FavoritesViewController(gitHubService: gitHubService)
        productDetailsFlowVC.title = "Favorites"
        productDetailsFlowVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return productDetailsFlowVC
    }
}
