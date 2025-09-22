//
//  ProductCard.swift
//  ProductListUI
//
//  Created by Batuhan Baran on 11.09.2025.
//

import Models
import SwiftUI
import UIComponentKit
import ProductListKit

// MARK: - Product Card Component
public struct ProductCard: View {
    public let product: ProductModel
    public var onTap: (() -> Void)? = nil
    public var onCartTap: (() -> Void)? = nil

    public init(
        product: ProductModel,
        onTap: (() -> Void)? = nil,
        onCartTap: (() -> Void)? = nil
    ) {
        self.product = product
        self.onTap = onTap
        self.onCartTap = onCartTap
    }

    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 0) {
                productImageSection
                productInfoSection
            }
            .background(Color(UIColor.systemBackground))
            .cornerRadius(ProductCardMetrics.cornerRadius)
            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
            .overlay(cardBorder)
            .contentShape(Rectangle())
            .onTapGesture { onTap?() }
        }
    }

    // MARK: - Private Views

    private var productImageSection: some View {
        ZStack(alignment: .topTrailing) {
            productImage
            imageOverlayContent
        }
    }

    private var productImage: some View {
        Group {
            if let url = product.thumbnail {
                CachedAsyncImage(url: .init(string: url))
            } else {
                Color.gray.opacity(0.2) // Placeholder for missing image
            }
        }
    }

    private var imageOverlayContent: some View {
        HStack {
            FavoriteButton(id: String(product.id ?? .zero))
            Spacer()
            discountBadge
        }
        .padding(8)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    @ViewBuilder
    private var discountBadge: some View {
        if let discount = product.discountPercentage, discount > 0 {
            DiscountBadge(percentage: discount)
        }
    }

    private var productInfoSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            categoryAndBrandSection
            titleSection
            ratingSection
            priceSection
            stockAndCartSection
        }
        .padding(.horizontal, ProductCardMetrics.innerPadding)
        .padding(.vertical, ProductCardMetrics.innerPadding)
    }

    private var categoryAndBrandSection: some View {
        Group {
            if product.category != nil || product.brand != nil {
                categoryBrandContent
                    .lineLimit(1)
                    .frame(height: ProductCardMetrics.catBrandHeight, alignment: .center)
            } else {
                Color.clear
                    .frame(height: ProductCardMetrics.catBrandHeight)
            }
        }
    }

    private var categoryBrandContent: some View {
        HStack(spacing: 4) {
            categoryText
            separatorText
            brandText
        }
    }

    @ViewBuilder
    private var categoryText: some View {
        if let category = product.category {
            Text(category.uppercased())
                .font(.caption2)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
        }
    }

    @ViewBuilder
    private var separatorText: some View {
        if product.category != nil && product.brand != nil {
            Text("•")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }

    @ViewBuilder
    private var brandText: some View {
        if let brand = product.brand {
            Text(brand)
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
        }
    }

    private var titleSection: some View {
        Text(product.title ?? "Unknown Product")
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundColor(.primary)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
            .frame(height: ProductCardMetrics.titleHeight, alignment: .topLeading)
    }

    private var ratingSection: some View {
        Group {
            if let rating = product.rating {
                RatingView(rating: rating, reviewCount: product.reviews?.count)
            } else {
                Color.clear
            }
        }
        .frame(height: ProductCardMetrics.ratingHeight, alignment: .center)
    }

    private var priceSection: some View {
        PriceView(
            price: product.price,
            discountPercentage: product.discountPercentage
        )
        .frame(height: ProductCardMetrics.priceHeight, alignment: .center)
    }

    private var stockAndCartSection: some View {
        HStack {
            StockStatusView(
                stock: product.stock,
                availabilityStatus: product.availabilityStatus
            )
            Spacer()
            cartButton
        }
    }

    private var cartButton: some View {
        CartButton(
            productId: String(product.id ?? .zero),
            isInCart: false,
            onTap: onCartTap
        )
    }

    private var cardBorder: some View {
        RoundedRectangle(cornerRadius: ProductCardMetrics.cornerRadius)
            .stroke(Color.gray.opacity(0.1), lineWidth: 1)
    }
}
