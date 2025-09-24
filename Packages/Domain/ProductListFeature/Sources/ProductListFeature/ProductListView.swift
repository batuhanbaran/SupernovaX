//
//  ProductListView.swift
//  ProductListFeature
//
//  Created by Batuhan Baran on 11.09.2025.
//

import ExtensionsKit
import Factory
import Models
import NavigatorUI
import ProductListUI
import ProductListKitLive
import ProductListKit
import SwiftUI
import UIComponentKit

@Observable
@MainActor
final class ProductListViewModel {
    var products: [ProductModel] = []
    var total: Int = .zero

    @ObservationIgnored
    @Injected(\.productListService)
    var productListService

    func fetchProductList(force: Bool = false) async {
        let response = await productListService.fetchProductList(by: nil)
        self.products = response?.products ?? []
        self.total = response?.total ?? .zero
    }
}

public struct ProductListView: View {
    @State private var viewModel = ProductListViewModel()
    @Environment(\.navigator) private var navigator

    public init() {}

    public var body: some View {
        @Bindable var vm = viewModel

        PaginationContainerView(
            items: $vm.products,
            path: "products",
            responseType: ProductListResponse.self,
            total: $vm.total,
            layout: .grid(columns: 2, spacing: 8)
        ) { product in
            ProductCard(
                product: product,
                onTap: {
                    // For now, just print until we implement product detail navigation
                    print("Navigate to product: \(product.id ?? .zero)")
                    navigator.push(ProductListDestination.productDetail(product.id ?? .zero))
                },
                onCartTap: {
                    // For now, just print until we implement cart navigation
                    print("Add to cart: \(product.id ?? .zero)")
                }
            )
        }
        .onFirstAppear {
            Task {
                await vm.fetchProductList()
            }
        }
        .padding(8)
        .navigationDestination(for: ProductListDestination.self) { destination in
            destination
        }
    }
}

public enum ProductListDestination: NavigationDestination {
    case productDetail(Int)

    public var body: some View {
        switch self {
        case .productDetail(let id):
            Text("Product \(id)")
        }
    }

    public var method: NavigationMethod {
        switch self {
        case .productDetail(_):
                .push
        }
    }
}
