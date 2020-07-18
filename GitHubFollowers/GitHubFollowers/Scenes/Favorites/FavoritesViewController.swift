//
//  FavoritesViewController.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 15.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit
import Combine

class FavoritesViewController: UIViewController {
    let gitHubService = GitHubService(networking: URLSession.shared.erasedDataTaskPublisher)
    var subscription: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        subscription = gitHubService.fetchUserInfo(for: "cardoso").sink(receiveCompletion: { completion in
           print(completion)
        }) { (userInfo) in
            print(userInfo)
        }
    }
}
