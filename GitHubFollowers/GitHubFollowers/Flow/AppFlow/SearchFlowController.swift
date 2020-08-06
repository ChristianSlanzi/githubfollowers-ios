//
//  SearchFlowController.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 05.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

final class SearchFlowController: UIViewController {
    private var embeddedNavigationController: UINavigationController!
    weak var delegate: AppFlowControllerDelegate?
    
    private let gitHubManager: GitHubNetworking

    init(gitHubManager: GitHubNetworking) {
        self.gitHubManager = gitHubManager
        super.init(nibName: nil, bundle: nil)

        embeddedNavigationController = UINavigationController()
        add(childController: embeddedNavigationController)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        let searchViewModel = SearchViewModel(input: SearchViewModel.Input(username: ""))
        let searchVC = SearchViewController(viewModel: searchViewModel)
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        searchVC.flowDelegate = self
        embeddedNavigationController.viewControllers = [searchVC]
    }
}

extension SearchFlowController: AppFlowControllerDelegate {
    func shouldHideToolbar(hide: Bool) {
        self.delegate?.shouldHideToolbar(hide: hide)
    }
    func showFollowers(forUser name: String) {
        DispatchQueue.main.async {
            let followersViewModel = FollowersViewModel(input: FollowersViewModel.Input(userName: name), gitHubManager: self.gitHubManager)
            let followerVC = FollowersViewController(viewModel: followersViewModel)
            followerVC.flowDelegate = self
            self.delegate?.shouldHideToolbar(hide: true)
            self.embeddedNavigationController?.show(followerVC, sender: self)
        }
    }
    
    func showProfile(forUsername name: String) {
        print("show profile view controller")
        DispatchQueue.main.async {
            let userProfileViewModel = UserProfileViewModel(input: UserProfileViewModel.Input(username: name), gitHubManager: self.gitHubManager)
            let userProfileVC = UserProfileViewController(viewModel: userProfileViewModel)
            userProfileVC.flowDelegate = self
            self.delegate?.shouldHideToolbar(hide: true)
            self.embeddedNavigationController?.show(userProfileVC, sender: self)
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
