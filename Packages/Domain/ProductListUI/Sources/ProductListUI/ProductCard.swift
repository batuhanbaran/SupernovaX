//
//  ProductCard.swift
//  ProductListUI
//
//  Created by Batuhan Baran on 11.09.2025.
//

import Models
import SwiftUI

// MARK: - Product Card Component
public struct ProductCard: View {
    public let product: ProductModel
    public var onTap: (() -> Void)? = nil

    @State private var imageLoadFailed = false

    public init(product: ProductModel, onTap: (() -> Void)? = nil) {
        self.product = product
        self.onTap = onTap
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image (1:1)
            ZStack(alignment: .topTrailing) {
                ProductImageView(
                    imageURL: product.thumbnail,
                    imageLoadFailed: $imageLoadFailed
                )

                HStack {
                    FavoriteButton(id: String(product.id ?? .zero))

                    Spacer()
                    if let discount = product.discountPercentage, discount > 0 {
                        DiscountBadge(percentage: discount)
                    }
                }
                .padding(8)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }

            // Info
            VStack(alignment: .leading, spacing: 8) {

                // Category • Brand (sabit yükseklik)
                if product.category != nil || product.brand != nil {
                    HStack(spacing: 4) {
                        if let category = product.category {
                            Text(category.uppercased())
                                .font(.caption2).fontWeight(.semibold)
                                .foregroundColor(.secondary)
                        }
                        if product.category != nil && product.brand != nil {
                            Text("•").font(.caption2).foregroundColor(.secondary)
                        }
                        if let brand = product.brand {
                            Text(brand)
                                .font(.caption2).fontWeight(.medium)
                                .foregroundColor(.secondary)
                        }
                    }
                    .lineLimit(1)
                    .frame(height: ProductCardMetrics.catBrandHeight, alignment: .center)
                } else {
                    Color.clear.frame(height: ProductCardMetrics.catBrandHeight)
                }

                // Title (2 satır sabit yükseklik)
                Text(product.title ?? "Unknown Product")
                    .font(.headline).fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .frame(height: ProductCardMetrics.titleHeight, alignment: .topLeading)

                // Rating (yoksa placeholder)
                Group {
                    if let rating = product.rating {
                        RatingView(rating: rating, reviewCount: product.reviews?.count)
                    } else {
                        Color.clear.frame(height: ProductCardMetrics.ratingHeight)
                    }
                }
                .frame(height: ProductCardMetrics.ratingHeight, alignment: .center)

                // Price (sabit yükseklik)
                PriceView(
                    price: product.price,
                    discountPercentage: product.discountPercentage
                )
                .frame(height: ProductCardMetrics.priceHeight, alignment: .center)

                // Stock (sabit)
                StockStatusView(
                    stock: product.stock,
                    availabilityStatus: product.availabilityStatus
                )
                .frame(height: ProductCardMetrics.stockHeight, alignment: .center)
            }
            .padding(.horizontal, ProductCardMetrics.innerPadding)
            .padding(.vertical, ProductCardMetrics.innerPadding)
        }
        .background(Color(UIColor.systemBackground))
        .cornerRadius(ProductCardMetrics.cornerRadius)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: ProductCardMetrics.cornerRadius)
                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
        )
        .contentShape(Rectangle())
        .onTapGesture { onTap?() }
    }
}
