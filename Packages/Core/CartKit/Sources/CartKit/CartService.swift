//
//  CartService.swift
//  CartKit
//
//  Created by Batuhan Baran on 15.09.2025.
//

import Foundation

public protocol CartService {
    func add(item: CartItemModel)
    func remove(item: CartItemModel)
}
