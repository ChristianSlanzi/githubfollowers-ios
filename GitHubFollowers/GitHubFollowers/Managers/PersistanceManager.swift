//
//  PersistanceManager.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 02.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

/// Error Messages with raw values for user display
enum PersistanceError: String, Error {
    case unableToFavorite = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites = "You've already favorited this user. You must REALLY like them!"
}

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {

    // MARK: - Properties

    //TODO: having a static property makes it difficult to test isolation
    //
    static private let defaults = UserDefaults.standard

    enum Keys { static let favorites = "favorites" }

    // MARK: - Public Methods

    static func updateWith(favorite: Follower,
                           actionType: PersistenceActionType,
                           completed: @escaping (PersistanceError?) -> Void) {
            retrieveFavorites { (result) in
            switch result {
            case .success(var favorites):

                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    favorites.append(favorite)

                case .remove:
                    favorites.removeAll { $0.login == favorite.login }
                }

                completed(save(favorites: favorites))

            case .failure(let error):
                completed(error)
            }
        }
    }

    /// Retreive Favorites
    static func retrieveFavorites(completed: @escaping (Result<[Follower], PersistanceError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([])) // return a blank array if there is no stored object
            return
        }

        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }

    /// Save Favorites
    static func save(favorites: [Follower]) -> PersistanceError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }

}
