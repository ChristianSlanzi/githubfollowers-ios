//
//  FavoritesViewModel.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 02.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol FavoritesViewModelInputsType {
    func viewDidLoad()
    func didSelectRowAt(_ indexPath: IndexPath)
}

protocol FavoritesViewModelOutputsType: AnyObject {
    var reloadData: (([Follower]) -> Void) { get set }
    var didReceiveServiceError: ((PersistanceError) -> Void) { get set }
    var showFollowersForUsername: ((String) -> Void) { get set }
}

protocol FavoritesViewModelType {
    var inputs: FavoritesViewModelInputsType { get }
    var outputs: FavoritesViewModelOutputsType { get }
}

final class FavoritesViewModel: FavoritesViewModelType, FavoritesViewModelInputsType, FavoritesViewModelOutputsType {
    
    struct Input {
        //passing in data the viewModel needs from the view controller
    }
    
    struct Output {
        
    }
    
    // MARK: properties
    var inputs: FavoritesViewModelInputsType { return self }
    var outputs: FavoritesViewModelOutputsType { return self }

    
    var favorites: [Follower] = []
    
    // MARK: - Input
    public func viewDidLoad() {
        PersistenceManager.retrieveFavorites { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let followers):
                self.favorites = followers
                self.reloadData(followers)
                break
            case .failure(let error):
                self.didReceiveServiceError(error)
                break
            }
        }
    }
    
    public func didSelectRowAt(_ indexPath: IndexPath) {
        let follower = self.favorites[indexPath.row]
        showFollowersForUsername(follower.login)
    }
    
    // MARK: - Output
    //output
    public var reloadData: (([Follower]) -> Void) = { _ in }
    public var didReceiveServiceError: ((PersistanceError) -> Void) = { _ in }
    public var showFollowersForUsername: ((String) -> Void) = { _ in }
}
