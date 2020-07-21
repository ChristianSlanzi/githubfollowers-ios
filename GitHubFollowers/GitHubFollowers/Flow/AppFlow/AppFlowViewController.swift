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
        tabController.viewControllers = [createSearchNavigationController(),
                                         createFavoritesListNavigationController()]
        add(tabController)
    }
    
    private func createSearchNavigationController() -> UIViewController {
        let searchViewModel = SearchViewModel(input: SearchViewModel.Input(userName: ""), gitHubManager: gitHubManager)
        let productsFlowVC = SearchViewController(viewModel: searchViewModel)
        productsFlowVC.title = "Search"
        productsFlowVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return productsFlowVC
    }
    
    private func createFavoritesListNavigationController() -> UIViewController {
        let productDetailsFlowVC = FavoritesViewController()
        productDetailsFlowVC.title = "Favorites"
        productDetailsFlowVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return productDetailsFlowVC
    }
}
