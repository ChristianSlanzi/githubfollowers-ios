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
    
    public func compose() -> UINavigationController {
        let rootNC = UINavigationController(rootViewController: buildInitialViewController())
        return rootNC
    }
    
    private func buildInitialViewController() -> UIViewController {
        return ViewController()
    }
}
