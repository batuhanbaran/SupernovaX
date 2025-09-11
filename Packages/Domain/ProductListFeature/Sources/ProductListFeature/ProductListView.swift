//
//  ProductListView.swift
//  ProductListFeature
//
//  Created by Batuhan Baran on 11.09.2025.
//

import Factory
import Models
import ProductListUI
import ProductListKitLive
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
            ProductCard(product: product)
        }
        .task {
            await vm.fetchProductList()
        }
        .padding(8)
    }
}
