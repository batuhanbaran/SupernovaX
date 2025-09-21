//
//  CartItemModel.swift
//  CartKit
//
//  Created by Batuhan Baran on 15.09.2025.
//

import Foundation

public struct CartItemModel: Sendable, Identifiable, Hashable {
    public let id: String

    public init(id: String) {
        self.id = id
    }
}
