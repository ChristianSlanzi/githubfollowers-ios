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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabController.viewControllers = [createSearchNavigationController(),
                                         createFavoritesListNavigationController()]
        add(tabController)
    }
    
    private func createSearchNavigationController() -> UIViewController {
        let productsFlowVC = ViewController()
        productsFlowVC.title = "Search"
        productsFlowVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return productsFlowVC
    }
    
    private func createFavoritesListNavigationController() -> UIViewController {
        let productDetailsFlowVC = ViewController()
        productDetailsFlowVC.title = "Favorites"
        productDetailsFlowVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return productDetailsFlowVC
    }
}
