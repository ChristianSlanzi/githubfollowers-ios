//
//  CompositionRoot.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 13.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

//public protocol Composing { func compose() -> UINavigationController }

public final class CompositionRoot {
    var initialVC: UIViewController?

    public func compose() -> UIViewController {
        //let rootNC = UINavigationController(rootViewController: buildInitialViewController())
        return buildInitialViewController()//rootNC
    }
    
    private func buildInitialViewController() -> UIViewController {
        return AppFlowController(gitHubManager: buildGitHubManager())
    }
    
    private func buildGitHubManager() -> GitHubNetworking {
        return GitHubManager(gitHubService: buildGitHubService(MOCKED: false))
    }
    
    private func buildGitHubService(MOCKED: Bool = false) -> GitHubService {
        return MOCKED ? buildMockedService(data: buildDataFor(followers: buildThreeFollowers())) : GitHubClient(networking: URLSession.shared.erasedDataTaskPublisher)
    }
}
