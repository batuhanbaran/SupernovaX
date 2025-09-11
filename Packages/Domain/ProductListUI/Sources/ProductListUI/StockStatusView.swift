//
//  StockStatusView.swift
//  ProductListUI
//
//  Created by Batuhan Baran on 11.09.2025.
//

import SwiftUI

// MARK: - Stock Status View
public struct StockStatusView: View {
    public let stock: Int?
    public let availabilityStatus: String?

    public init(stock: Int?, availabilityStatus: String?) {
        self.stock = stock
        self.availabilityStatus = availabilityStatus
    }

    private var stockColor: Color {
        guard let stock = stock else { return .gray }
        if stock == 0 { return .red }
        if stock < 10 { return .orange }
        return .green
    }

    private var stockText: String {
        if let status = availabilityStatus {
            return status
        }
        guard let stock = stock else { return "Status Unknown" }
        if stock == 0 { return "Out of Stock" }
        if stock < 10 { return "Low Stock (\(stock) left)" }
        return "In Stock"
    }

    public var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(stockColor)
                .frame(width: 6, height: 6)

            Text(stockText)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(stockColor)
        }
    }
}
