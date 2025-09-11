//
//  FavoriteModel.swift
//  FavoriteKit
//
//  Created by Batuhan Baran on 10.09.2025.
//

import Foundation

public struct FavoriteModel: Sendable, Identifiable, Hashable {
    public let id: String

    public init(id: String) {
        self.id = id
    }

    public static func random() -> Self {
        let range = 0x1F300...0x1FAD6
        let scalar = UnicodeScalar(Int.random(in: range))!
        return FavoriteModel(id: String(scalar))
    }
}
