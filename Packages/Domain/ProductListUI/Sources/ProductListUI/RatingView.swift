//
//  RatingView.swift
//  ProductListUI
//
//  Created by Batuhan Baran on 11.09.2025.
//

import SwiftUI

// MARK: - Rating View
public struct RatingView: View {
    public let rating: Double
    public let reviewCount: Int?

    public init(rating: Double, reviewCount: Int? = nil) {
        self.rating = rating
        self.reviewCount = reviewCount
    }

    public var body: some View {
        HStack(spacing: 4) {
            HStack(spacing: 2) {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= Int(rating.rounded()) ? "star.fill" : "star")
                        .font(.system(size: 12))
                        .foregroundColor(index <= Int(rating.rounded()) ? .yellow : .gray.opacity(0.3))
                }
            }

            Text(String(format: "%.1f", rating))
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.secondary)

            if let count = reviewCount, count > 0 {
                Text("(\(count))")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}
