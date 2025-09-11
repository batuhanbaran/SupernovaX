//
//  PriceView.swift
//  ProductListUI
//
//  Created by Batuhan Baran on 11.09.2025.
//

import SwiftUI

// MARK: - Price View
public struct PriceView: View {
    public let price: Double?
    public let discountPercentage: Double?

    public init(price: Double?, discountPercentage: Double?) {
        self.price = price
        self.discountPercentage = discountPercentage
    }

    private var originalPrice: Double? {
        guard let price = price, let discount = discountPercentage, discount > 0 else {
            return nil
        }
        return price / (1 - discount / 100)
    }

    public var body: some View {
        HStack(spacing: 6) {
            if let price = price {
                Text("$\(String(format: "%.2f", price))")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }

            if let original = originalPrice {
                Text("$\(String(format: "%.2f", original))")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .strikethrough()
            }
        }
    }
}
