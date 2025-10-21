//
//  FavoriteStorageLive.swift
//  FavoriteKitLive
//
//  Created by Batuhan Baran on 10.09.2025.
//

import FavoriteKit
import SwiftUI
import Foundation

@available(iOS 17.0, *)
public actor FavoriteStorageLive: FavoriteStorage {

    public static let shared = FavoriteStorageLive()

    // UserDefaults key for favorites
    private let favoritesKey = "com.supernova.favorites"
    
    // Private internal storage for caching
    private var _favorites: Set<FavoriteModel> = []
    private var isLoaded = false

    public func getFavorites() -> Set<FavoriteModel> {
        if !isLoaded {
            loadFromUserDefaults()
        }
        return _favorites
    }

    public func getCount() -> Int {
        getFavorites().count
    }

    public init() {
        // Load favorites on initialization
        Task {
            await loadFromUserDefaults()
        }
    }

    public func add(_ item: FavoriteModel) {
        _favorites.insert(item)
        saveToUserDefaults()
    }

    public func remove(_ item: FavoriteModel) {
        _favorites.remove(item)
        saveToUserDefaults()
    }

    public func clear() {
        _favorites.removeAll()
        saveToUserDefaults()
    }

    public func contains(_ item: FavoriteModel) -> Bool {
        getFavorites().contains(item)
    }
    
    // MARK: - Private Methods
    
    private func loadFromUserDefaults() {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey),
              let favorites = try? JSONDecoder().decode(Set<FavoriteModel>.self, from: data) else {
            _favorites = []
            isLoaded = true
            return
        }
        
        _favorites = favorites
        isLoaded = true
    }
    
    private func saveToUserDefaults() {
        guard let data = try? JSONEncoder().encode(_favorites) else {
            print("Failed to encode favorites")
            return
        }
        
        UserDefaults.standard.set(data, forKey: favoritesKey)
    }
}
