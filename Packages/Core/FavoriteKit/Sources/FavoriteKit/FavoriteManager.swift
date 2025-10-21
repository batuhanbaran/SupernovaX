//
//  FavoriteManager.swift
//  FavoriteKit
//
//  Created by Batuhan Baran on 12.09.2025.
//

import SwiftUI

@available(iOS 17.0, *)
@MainActor
public protocol FavoriteManager: AnyObject, Sendable {
    var badge: Int { get }
    var favorites: [FavoriteModel] { get }

    func add(_ item: FavoriteModel) async
    func remove(_ item: FavoriteModel) async
    func remove(at indexSet: IndexSet) async
    func toggle(_ item: FavoriteModel) async
    func isFavorite(_ item: FavoriteModel) async -> Bool
    func clearAll() async
    func refresh() async
}
