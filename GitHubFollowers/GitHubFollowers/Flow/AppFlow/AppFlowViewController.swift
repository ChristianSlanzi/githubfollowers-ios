//
//  AppFlowViewController.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 15.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

//protocol FlowController {
//  var navigationController: UINavigationController {get}
//}

class AppFlowViewController: UIViewController{
    
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
        let searchVC = SearchViewController(viewModel: searchViewModel)
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        searchVC.flowDelegate = self
        return searchVC
    }
    
    private func createFavoritesListNavigationController() -> UIViewController {
        let favoritesVC = FavoritesViewController()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return favoritesVC
    }
}

protocol AppFlowControllerDelegate: AnyObject {
    func showFollowers(_ followers: [Follower])
}

extension AppFlowViewController: AppFlowControllerDelegate {
    func showFollowers(_ followers: [Follower]) {
        DispatchQueue.main.async {
            let followersViewModel = FollowersViewModel()
            followersViewModel.followers = followers
            let followerVC = FollowersViewController(viewModel: followersViewModel)
            self.navigationController?.show(followerVC, sender: self)
        }
    }
}
