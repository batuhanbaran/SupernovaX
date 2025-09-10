//
//  VisibleItemCountHorizontalGrid.swift
//  UIComponentKit
//
//  Created by Batuhan Baran on 16.07.2025.
//

import SwiftUI

// MARK: - Visible Item Count Based Horizontal Grid
public struct VisibleItemCountHorizontalGrid<Item: Identifiable, Content: View>: View {
    let items: [Item]
    let visibleItemCount: CGFloat // 3.5 gibi değerler alabilir
    let spacing: CGFloat
    let itemHeight: CGFloat
    let content: (Item) -> Content

    public init(
        items: [Item],
        visibleItemCount: CGFloat = 3.5,
        spacing: CGFloat = 10,
        itemHeight: CGFloat = 200,
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self.items = items
        self.visibleItemCount = visibleItemCount
        self.spacing = spacing
        self.itemHeight = itemHeight
        self.content = content
    }

    public var body: some View {
        GeometryReader { geometry in
            let availableWidth = geometry.size.width
            let itemWidth = calculateItemWidth(availableWidth: availableWidth)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: spacing) {
                    ForEach(items) { item in
                        content(item)
                            .frame(width: itemWidth, height: itemHeight)
                    }
                }
                .padding(.horizontal, spacing)
            }
        }
        .frame(height: itemHeight)
    }

    private func calculateItemWidth(availableWidth: CGFloat) -> CGFloat {
        // Toplam padding (sol ve sağ)
        let totalPadding = spacing * 2

        // Görünür item'lar arasındaki spacing'ler
        // Örneğin 3.5 item için 2.5 spacing olacak (3.5 - 1 = 2.5)
        let totalSpacing = spacing * (visibleItemCount - 1)

        // Kullanılabilir genişlik
        let usableWidth = availableWidth - totalPadding - totalSpacing

        // Her item'ın genişliği
        return usableWidth / visibleItemCount
    }
}

// MARK: - Loading State için aynı mantık
public struct VisibleItemCountLoadingGrid: View {
    let visibleItemCount: CGFloat
    let spacing: CGFloat
    let itemHeight: CGFloat
    let shimmerEnabled: Bool

    public init(
        visibleItemCount: CGFloat = 3.5,
        spacing: CGFloat = 10,
        itemHeight: CGFloat = 200,
        shimmerEnabled: Bool = true
    ) {
        self.visibleItemCount = visibleItemCount
        self.spacing = spacing
        self.itemHeight = itemHeight
        self.shimmerEnabled = shimmerEnabled
    }

    public var body: some View {
        GeometryReader { geometry in
            let availableWidth = geometry.size.width
            let itemWidth = calculateItemWidth(availableWidth: availableWidth)
            let skeletonCount = Int(ceil(visibleItemCount)) // 3.5 -> 4 skeleton

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: spacing) {
                    ForEach(0..<skeletonCount, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: itemWidth, height: itemHeight)
                            .redacted(reason: .placeholder)
                    }
                }
                .padding(.horizontal, spacing)
            }
        }
        .frame(height: itemHeight)
    }

    private func calculateItemWidth(availableWidth: CGFloat) -> CGFloat {
        let totalPadding = spacing * 2
        let totalSpacing = spacing * (visibleItemCount - 1)
        let usableWidth = availableWidth - totalPadding - totalSpacing
        return usableWidth / visibleItemCount
    }
}
