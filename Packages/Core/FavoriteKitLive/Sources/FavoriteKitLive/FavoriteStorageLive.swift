//
//  FavoriteStorageLive.swift
//  FavoriteKitLive
//
//  Created by Batuhan Baran on 10.09.2025.
//

import FavoriteKit
import SwiftUI

@available(iOS 17.0, *)
public actor FavoriteStorageLive: FavoriteStorage {

    public static let shared = FavoriteStorageLive()

    // Private internal storage
    private var _favorites: Set<FavoriteModel> = []

    // Public computed property to satisfy protocol
    public var favorites: Set<FavoriteModel> {
        _favorites
    }

    public var count: Int {
        _favorites.count
    }

    private init() {}

    public func add(_ item: FavoriteModel) {
        _favorites.insert(item)
    }

    public func remove(_ item: FavoriteModel) {
        _favorites.remove(item)
    }

    public func clear() {
        _favorites.removeAll()
    }

    public func contains(_ item: FavoriteModel) -> Bool {
        _favorites.contains(item)
    }
}
