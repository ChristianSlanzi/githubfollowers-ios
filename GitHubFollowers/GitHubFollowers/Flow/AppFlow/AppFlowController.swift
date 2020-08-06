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

class AppFlowController: UIViewController{
    
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
        tabController.viewControllers = [startSearch(),
                                         startFavorites()]
        add(childController: tabController)
    }
    
    private func startSearch() -> UIViewController {
        let searchFlowController = SearchFlowController(gitHubManager: self.gitHubManager)
        searchFlowController.title = "Search"
        searchFlowController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        searchFlowController.navigationController?.setNavigationBarHidden(true, animated: true)
        searchFlowController.delegate = self
        add(childController: searchFlowController)
        searchFlowController.start()
        return searchFlowController
    }
    
    private func startFavorites() -> UIViewController {
        let favoritesFlowController = FavoritesFlowController(gitHubManager: self.gitHubManager)
        favoritesFlowController.title = "Favorites"
        favoritesFlowController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        favoritesFlowController.navigationController?.setNavigationBarHidden(true, animated: true)
        favoritesFlowController.delegate = self
        add(childController: favoritesFlowController)
        favoritesFlowController.start()
        return favoritesFlowController
    }
}

protocol AppFlowControllerDelegate: AnyObject {
    func shouldHideToolbar(hide: Bool)
    func showFollowers(forUser name: String)
    func showProfile(forUsername: String)
    func showGitHubPage(forUser user: User)
}

extension AppFlowController: AppFlowControllerDelegate {
    func shouldHideToolbar(hide: Bool) {
        tabController.tabBar.isHidden = hide
    }
    func showFollowers(forUser name: String) {
        DispatchQueue.main.async {
            let followersViewModel = FollowersViewModel(input: FollowersViewModel.Input(userName: name), gitHubManager: self.gitHubManager)
            let followerVC = FollowersViewController(viewModel: followersViewModel)
            followerVC.flowDelegate = self
            self.tabController.selectedViewController?.navigationController?.show(followerVC, sender: self)
        }
    }
    
    func showProfile(forUsername name: String) {
        print("show profile view controller")
        DispatchQueue.main.async {
            let userProfileViewModel = UserProfileViewModel(input: UserProfileViewModel.Input(username: name), gitHubManager: self.gitHubManager)
            let userProfileVC = UserProfileViewController(viewModel: userProfileViewModel)
            userProfileVC.flowDelegate = self
            self.tabController.selectedViewController?.navigationController?.show(userProfileVC, sender: self)
        }
    }
    
    func showGitHubPage(forUser user: User) {
        print("show git hub page")
        
        // show safari view controller
        guard let url = URL(string: user.htmlUrl) else {
            
            presentAlertOnMainThread(title: "Invalid URL",
                                     message: "The url attached to this user in invalid.",
                                     buttonTitle: "Ok")
            return
        }
        presentSafariViewController(with: url)
    }
}
