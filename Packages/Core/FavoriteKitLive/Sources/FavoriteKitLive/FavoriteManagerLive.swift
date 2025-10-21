//
//  FavoriteManagerLive.swift
//  FavoriteKitLive
//
//  Created by Batuhan Baran on 10.09.2025.
//

import FavoriteKit
import SwiftUI

@available(iOS 17.0, *)
@Observable
@MainActor
public final class FavoriteManagerLive: FavoriteManager {

    public private(set) var badge: Int = 0
    public private(set) var favorites: [FavoriteModel] = []

    private let storage: any FavoriteStorage

    public init(
        storage: any FavoriteStorage = FavoriteStorageLive.shared,
    ) {
        self.storage = storage
        Task {
            await refreshState()
        }
    }

    public func add(_ item: FavoriteModel) async {
        await storage.add(item)
        await refreshState()
    }

    public func remove(_ item: FavoriteModel) async {
        await storage.remove(item)
        await refreshState()
    }

    public func remove(at indexSet: IndexSet) async {
        let itemsToRemove = indexSet.map { favorites[$0] }
        for item in itemsToRemove {
            await storage.remove(item)
        }
        await refreshState()
    }

    public func toggle(_ item: FavoriteModel) async {
        let isFavorite = await storage.contains(item)
        if isFavorite {
            await remove(item)
        } else {
            await add(item)
        }
    }

    public func isFavorite(_ item: FavoriteModel) async -> Bool {
        await storage.contains(item)
    }

    public func clearAll() async {
        await storage.clear()
        await refreshState()
    }

    public func refresh() async {
        await refreshState()
    }

    private func refreshState() async {
        let currentFavorites = await storage.getFavorites()
        self.favorites = Array(currentFavorites).sorted { $0.id < $1.id }
        self.badge = currentFavorites.count
    }
}

// Factory for creating instances
public struct FavoriteManagerFactory {
    @MainActor
    public static func makeDefault() -> any FavoriteManager {
        FavoriteManagerLive()
    }
}

// Use a lazy initialization
private struct FavoriteManagerKey: EnvironmentKey {
    // Use a computed property instead of stored
    static var defaultValue: any FavoriteManager {
        // This assumes SwiftUI will call this on main thread
        if Thread.isMainThread {
            return MainActor.assumeIsolated {
                FavoriteManagerLive()
            }
        } else {
            // Fallback - though this shouldn't happen in normal SwiftUI usage
            fatalError("FavoriteManager should only be accessed on main thread")
        }
    }
}

extension EnvironmentValues {
    public var favoriteManager: any FavoriteManager {
        get { self[FavoriteManagerKey.self] }
        set { self[FavoriteManagerKey.self] = newValue }
    }
}
