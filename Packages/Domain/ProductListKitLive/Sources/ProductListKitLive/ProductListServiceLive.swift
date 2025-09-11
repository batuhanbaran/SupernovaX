//
//  ProductListServiceLive.swift
//  ProductListKitLive
//
//  Created by Batuhan Baran on 11.09.2025.
//

import Factory
import Foundation
import Models
import NetworkKit
import UIComponentKit

struct ProductListEndpoint: Endpoint {
    var path: String
    var queryParameters: [String: String]?

    typealias Response = ProductListResponse

    init(query: String? = nil, limit: Int = 20) {
        self.path = query?.isEmpty == false ? "products/search" : "products"

        var params = ["limit": "\(limit)"]
        if let query = query?.trimmingCharacters(in: .whitespaces), !query.isEmpty {
            params["q"] = query
        }

        self.queryParameters = params.isEmpty ? nil : params
    }
}

@MainActor
public protocol ProductListService {
    func fetchProductList(by query: String?) async -> ProductListResponse?
}

final class ProductListServiceLive: ProductListService {
    @LazyInjected(\.networkService) private var network: NetworkServiceProtocol

    func fetchProductList(by query: String?) async -> ProductListResponse? {
        let endpoint = ProductListEndpoint(query: query)
        guard let response = try? await network.execute(endpoint) else { return nil }
        return response
    }
}

public extension Container {
    var productListService: Factory<ProductListService> {
        Factory(self) { ProductListServiceLive() }
    }
}
