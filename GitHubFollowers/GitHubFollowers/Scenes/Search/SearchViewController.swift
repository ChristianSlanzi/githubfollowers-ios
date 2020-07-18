//
//  SearchViewController.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 15.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    var gitHubService: GitHubService
    var subscription: AnyCancellable?
    
    init(gitHubService: GitHubService) {
        self.gitHubService = gitHubService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        subscription = gitHubService.fetchFollowers(for: "cardoso", page: 0).sink(receiveCompletion: { completion in
           print(completion)
        }) { (followers) in
            print(followers)
        }
    }
}
