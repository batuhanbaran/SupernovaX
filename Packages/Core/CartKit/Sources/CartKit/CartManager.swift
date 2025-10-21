//
//  CartManager.swift
//  CartKit
//
//  Created by Batuhan Baran on 25.09.2025.
//

import Foundation

public protocol CartManager: Sendable {
    func add(item: CartItemModel)
    func remove(item: CartItemModel)
}
