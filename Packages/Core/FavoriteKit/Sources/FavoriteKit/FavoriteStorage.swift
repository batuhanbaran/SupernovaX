//
//  FavoriteStorage.swift
//  FavoriteKit
//
//  Created by Batuhan Baran on 10.09.2025.
//

import SwiftUI

@available(iOS 17.0, *)
public protocol FavoriteStorage: Sendable {
    var count: Int { get async }
    var favorites: Set<FavoriteModel> { get async }
    func add(_ item: FavoriteModel) async
    func remove(_ item: FavoriteModel) async
    func clear() async
    func contains(_ item: FavoriteModel) async -> Bool
}
