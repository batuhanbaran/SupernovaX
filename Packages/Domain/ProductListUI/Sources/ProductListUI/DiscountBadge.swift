//
//  DiscountBadge.swift
//  ProductListUI
//
//  Created by Batuhan Baran on 11.09.2025.
//

import SwiftUI

// MARK: - Discount Badge
public struct DiscountBadge: View {
    public let percentage: Double

    public init(percentage: Double) {
        self.percentage = percentage
    }

    public var body: some View {
        Text("-\(Int(percentage))%")
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.red)
            .cornerRadius(6)
    }
}
