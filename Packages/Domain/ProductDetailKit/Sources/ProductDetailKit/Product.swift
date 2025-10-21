//
//  Product.swift
//  ProductDetailKit
//
//  Created by Batuhan Baran on 17.10.2025.
//


// Product model shared across modules
public struct Product: Identifiable, Hashable {
    public let id: String
    public let name: String
    public let price: Double
    public let description: String
    
    public init(id: String, name: String, price: Double, description: String) {
        self.id = id
        self.name = name
        self.price = price
        self.description = description
    }
}