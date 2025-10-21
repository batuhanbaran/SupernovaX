//
//  ProductDetailView.swift
//  ProductDetailFeatureLive
//
//  Created by Batuhan Baran on 16.10.2025.
//

import AppDestinationKit
import NavigatorUI
import ProductDetailKit
import SwiftUI

// Local navigation for ProductDetail feature
public enum ProductDetailDestinations: NavigationDestination {
    case list
    case reviews(productId: String)
    case relatedProducts(productId: String)

    public var body: some View {
        ProductDetailDestinationsView(destination: self)
    }
}

// View provider for local navigation
private struct ProductDetailDestinationsView: View {
    let destination: ProductDetailDestinations
    @Environment(\.navigator) var navigator

    var body: some View {
        switch destination {
        case .list:
            // Navigate to shared destination
            Color.clear.onAppear {
                navigator.navigate(to: AppDestinations.productList)
            }
        case .reviews(let productId):
            ProductReviewsView(productId: productId)
        case .relatedProducts(let productId):
            RelatedProductsView(productId: productId)
        }
    }
}

public struct ProductDetailView: View {
    let productId: String
    @Environment(\.navigator) var navigator
    @State private var product: Product?

    public init(productId: String) {
        self.productId = productId
    }

    public var body: some View {
        ScrollView {
            if let product = product {
                VStack(alignment: .leading, spacing: 16) {
                    Text(product.name)
                        .font(.largeTitle)
                        .bold()

                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.title2)
                        .foregroundColor(.blue)

                    Text(product.description)
                        .font(.body)
                        .foregroundColor(.secondary)

                    Divider()

                    // Navigation buttons
                    VStack(spacing: 12) {
                        Button {
                            navigator.navigate(to: ProductDetailDestinations.reviews(productId: productId))
                        } label: {
                            HStack {
                                Image(systemName: "star.fill")
                                Text("View Reviews")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }

                        Button {
                            navigator.navigate(to: ProductDetailDestinations.relatedProducts(productId: productId))
                        } label: {
                            HStack {
                                Image(systemName: "square.grid.2x2")
                                Text("Related Products")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }

                        Button {
                            // Navigate back to product list
                            navigator.navigate(to: AppDestinations.productList)
                        } label: {
                            HStack {
                                Image(systemName: "list.bullet")
                                Text("Back to Product List")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                        }
                    }
                }
                .padding()
            } else {
                ProgressView()
            }
        }
        .navigationTitle("Product Details")
        .navigationCheckpoint(AppNavigationCheckpoints.productDetail)
        .navigationAutoReceive(AppDestinations.self)
        .onAppear {
            loadProduct()
        }
    }

    private func loadProduct() {
        // Simulate loading
        let products = [
            Product(id: "1", name: "iPhone 15", price: 999, description: "Latest iPhone with amazing features"),
            Product(id: "2", name: "MacBook Pro", price: 2499, description: "Powerful laptop for professionals"),
            Product(id: "3", name: "AirPods Pro", price: 249, description: "Wireless earbuds with noise cancellation")
        ]
        product = products.first { $0.id == productId }
    }
}

// Supporting views
private struct ProductReviewsView: View {
    let productId: String

    var body: some View {
        List {
            ForEach(1...5, id: \.self) { index in
                VStack(alignment: .leading) {
                    Text("Review \(index)")
                        .font(.headline)
                    Text("Great product!")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Reviews")
    }
}

private struct RelatedProductsView: View {
    let productId: String
    @Environment(\.navigator) var navigator

    var body: some View {
        List {
            ForEach(["A", "B", "C"], id: \.self) { id in
                Button {
                    navigator.navigate(to: AppDestinations.productDetail(productId: id))
                } label: {
                    Text("Related Product \(id)")
                }
            }
        }
        .navigationTitle("Related Products")
    }
}
