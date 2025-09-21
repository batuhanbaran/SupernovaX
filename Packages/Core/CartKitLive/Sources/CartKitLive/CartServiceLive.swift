//
//  CartServiceLive.swift
//  CartKitLive
//
//  Created by Batuhan Baran on 15.09.2025.
//

import CartKit
import Factory
import Foundation
import NetworkKit

public final class CartServiceLive: CartService {

    @LazyInjected(\.networkService)
    var networkService

    public func add(item: CartItemModel) {}

    public func remove(item: CartItemModel) {}

}

extension Container {
    public var cartService: Factory<CartService> {
        self { CartServiceLive() }
    }
}
