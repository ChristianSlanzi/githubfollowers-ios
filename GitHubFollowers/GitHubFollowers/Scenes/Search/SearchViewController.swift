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
    let gitHubService = GitHubService(networking: URLSession.shared.erasedDataTaskPublisher)
    var subscription: AnyCancellable?
    
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
