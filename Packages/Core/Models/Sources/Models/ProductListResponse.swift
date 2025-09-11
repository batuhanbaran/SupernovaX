//
//  ProductListResponse.swift
//  Models
//
//  Created by Batuhan Baran on 11.09.2025.
//

import Foundation

public struct ProductListResponse: PaginatedResponse {
    public let products: [ProductModel]
    public let total: Int
    public let skip: Int
    public let limit: Int
    public var items: [ProductModel] {
        products
    }

    public init(products: [ProductModel], total: Int, skip: Int, limit: Int) {
        self.products = products
        self.total = total
        self.skip = skip
        self.limit = limit
    }
}
