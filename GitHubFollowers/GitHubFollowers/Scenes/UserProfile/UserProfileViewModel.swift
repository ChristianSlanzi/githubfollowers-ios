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
    var didReceiveServiceError: ((Error) -> Void) { get set }
    var reloadData: (() -> Void) { get set }
    var showAddToFavoritesResult: ((PersistanceError?) -> Void) { get set }
}

protocol UserProfileViewModelType {
    var inputs: UserProfileViewModelInputsType { get }
    var outputs: UserProfileViewModelOutputsType { get }
}

final class UserProfileViewModel: UserProfileViewModelType, UserProfileViewModelInputsType, UserProfileViewModelOutputsType {
    
    private let gitHubManager: GitHubNetworking
    
    struct Input {
        //passing in data the viewModel needs from the view controller
        //var user: User
        var username: String
    }
    
    struct Output {
        
    }
    
    private var input: Input
    
    init(input: Input, gitHubManager: GitHubNetworking) {
        self.input = input
        self.gitHubManager = gitHubManager
    }
    
    var inputs: UserProfileViewModelInputsType { return self }
    var outputs: UserProfileViewModelOutputsType { return self }
    
    private var user: User?
    var profileViewModel: ProfileViewModel?
    var gitHubCardViewModel: GitHubCardViewModel?
    var followersCardViewModel: FollowersCardViewModel?
    
    //input
    public func viewDidLoad() {
        gitHubManager.fetchUserInfo(for: input.username) { (result) in
            switch result {
            case .success(let user):
                self.user = user
                self.profileViewModel?.setUser(user)
                self.gitHubCardViewModel?.setUser(user)
                self.followersCardViewModel?.setUser(user)
                self.reloadData()
                break
            case .failure(let error):
                self.didReceiveServiceError(error)
            }
        }
    }
    
    public func didTapAddToFavoriteButton() {
        addUserToFavorites(user: user!)
    }
    
    //output
    public var didReceiveServiceError: ((Error) -> Void) = { _ in }
    
    public var reloadData: () -> Void = {
        
    }
    
    public var showAddToFavoritesResult: ((PersistanceError?) -> Void) = { _ in }
    
    func getProfileViewModel() -> ProfileViewModel {
        profileViewModel = ProfileViewModel(input: ProfileViewModel.Input(user: user))
        return profileViewModel!
    }
    
    func getGitHubCardViewModel() -> GitHubCardViewModel {
        gitHubCardViewModel = GitHubCardViewModel(input: GitHubCardViewModel.Input(user: user))
        return gitHubCardViewModel!
    }
    
    func getFollowersCardViewModel() -> FollowersCardViewModel {
        followersCardViewModel = FollowersCardViewModel(input: FollowersCardViewModel.Input(user: user))
        return followersCardViewModel!
    }
    
    func getUserCreatedAt() -> Date? {
        return user?.createdAt
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
