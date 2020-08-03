//
//  UserProfileViewModel.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 27.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol UserProfileViewModelInputsType {
    func viewDidLoad()
    func didTapAddToFavoriteButton()
}

protocol UserProfileViewModelOutputsType: AnyObject {
    var showAddToFavoritesResult: ((PersistanceError?) -> Void) { get set }
}

protocol UserProfileViewModelType {
    var inputs: UserProfileViewModelInputsType { get }
    var outputs: UserProfileViewModelOutputsType { get }
}

class UserProfileViewModel: UserProfileViewModelType, UserProfileViewModelInputsType, UserProfileViewModelOutputsType {
    
    struct Input {
        //passing in data the viewModel needs from the view controller
        var user: User
    }
    
    struct Output {
        
    }
    
    private var input: Input
    
    init(input: Input) {
        self.input = input
    }
    
    var inputs: UserProfileViewModelInputsType { return self }
    var outputs: UserProfileViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
    }
    
    public func didTapAddToFavoriteButton() {
        addUserToFavorites(user: input.user)
    }
    
    //output
    public var showAddToFavoritesResult: ((PersistanceError?) -> Void) = { _ in }
    
    func getProfileViewModel() -> ProfileViewModel {
        return ProfileViewModel(
            input: ProfileViewModel.Input(user: input.user)
        )
    }
    
    func getGitHubCardViewModel() -> GitHubCardViewModel {
        return GitHubCardViewModel(input: GitHubCardViewModel.Input(user: input.user))
    }
    
    func getFollowersCardViewModel() -> FollowersCardViewModel {
        return FollowersCardViewModel(input: FollowersCardViewModel.Input(user: input.user))
    }
    
    private func addUserToFavorites(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else { // if the update error is nil, Success!
                self.showAddToFavoritesResult(nil)
                return
            }
            self.showAddToFavoritesResult(error)
        }
    }
}
