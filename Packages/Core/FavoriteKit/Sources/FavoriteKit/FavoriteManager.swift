//
//  FavoriteManager.swift
//  FavoriteKitLive
//
//  Created by Batuhan Baran on 10.09.2025.
//

import SwiftUI

@available(iOS 17.0, *)
@Observable
@MainActor
public final class FavoriteManager: ObservableObject, Sendable {

    public private(set) var badge: Int = 0
    public private(set) var favorites: [FavoriteModel] = []
    public private(set) var isLoading: Bool = false

    private let storage: any FavoriteStorage

    public init(storage: any FavoriteStorage) {
        self.storage = storage
        Task {
            await refreshState()
        }
    }

    public func add(_ item: FavoriteModel) async {
        isLoading = true
        await storage.add(item)
        await refreshState()
        isLoading = false
    }

    public func remove(_ item: FavoriteModel) async {
        isLoading = true
        await storage.remove(item)
        await refreshState()
        isLoading = false
    }

    public func remove(at indexSet: IndexSet) async {
        isLoading = true
        let itemsToRemove = indexSet.map { favorites[$0] }
        for item in itemsToRemove {
            await storage.remove(item)
        }
        await refreshState()
        isLoading = false
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
        isLoading = true
        await storage.clear()
        await refreshState()
        isLoading = false
    }

    public func refresh() async {
        await refreshState()
    }

    private func refreshState() async {
        let currentFavorites = await storage.favorites
        let currentCount = await storage.count

        self.favorites = Array(currentFavorites).sorted { $0.id < $1.id }
        self.badge = currentCount
    }
}

