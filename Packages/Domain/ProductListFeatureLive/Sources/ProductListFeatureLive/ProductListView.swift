//
//  ProductListView.swift
//  ProductListFeatureLive
//
//  Created by Batuhan Baran on 16.10.2025.
//

import AppDestinationKit
import NavigatorUI
import Factory
import ProductListKit
import ProductListKitLive
import FavoriteKit
import FavoriteKitLive
import ProductListUI
import SwiftUI
import UIComponentKit
import UserKit

public enum ProductListDestinations: NavigationDestination {
    case detail(productId: String)
    case settings

    public var body: some View {
        ProductListDestinationsView(destination: self)
    }
}

private struct ProductListDestinationsView: View {
    let destination: ProductListDestinations
    @Environment(\.navigator) var navigator

    var body: some View {
        switch destination {
        case .detail(let productId):
            // Navigate to shared destination
            Color.clear.onAppear {
                navigator.navigate(to: AppDestinations.productDetail(productId: productId))
            }
        case .settings:
            Text("Settings View")
        }
    }
}

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
    @State private var viewModel: ProductListViewModel = .init()
    @Environment(\.navigator) private var navigator
    @Environment(FavoriteManagerLive.self) private var favoriteManager

    @Injected(\.appUser)
    var appUser

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
            ProductCardWrapper(
                product: product,
                favoriteManager: favoriteManager,
                navigator: navigator,
                onFavoriteToggle: handleFavoriteToggle
            )
        }
        .onFirstAppear {
            Task {
                await vm.fetchProductList()
            }
        }
        .padding(8)
    }

    func handleFavoriteToggle(_ product: ProductModel) async {
        guard await appUser?.isLoggedIn ?? false else {
            navigator.navigate(to: AppDestinations.authentication, method: .managedSheet)
            return
        }

        await favoriteManager.toggle(.init(id: String(product.id ?? .zero)))
    }
}

// MARK: - ProductCardWrapper
private struct ProductCardWrapper: View {
    let product: ProductModel
    let favoriteManager: FavoriteManagerLive
    let navigator: Navigator
    let onFavoriteToggle: (ProductModel) async -> Void
    
    @State private var isFavorite: Bool = false
    
    var body: some View {
        ProductCard(
            product: product,
            isFavorite: $isFavorite,
            onTap: {
                navigator.navigate(to: AppDestinations.productDetail(productId: "\(product.id ?? .zero)"))
            },
            onCartTap: {
                // Cart functionality
            },
            onFavoriteTap: {
                Task {
                    await onFavoriteToggle(product)
                }
            }
        )
        .onAppear {
            updateFavoriteStatus()
        }
        .onChange(of: favoriteManager.favorites) { _, _ in
            updateFavoriteStatus()
        }
    }
    
    private func updateFavoriteStatus() {
        let newStatus = favoriteManager.favorites.contains { $0.id == String(product.id ?? .zero) }
        if isFavorite != newStatus {
            isFavorite = newStatus
            print("🔄 Updated favorite status for product \(product.id ?? .zero): \(isFavorite)")
        }
    }
}
