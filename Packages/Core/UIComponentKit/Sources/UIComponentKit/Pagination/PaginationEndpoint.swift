//
//  PaginationEndpoint.swift
//  DummyUser
//
//  Created by Batuhan BARAN on 12.06.2025.
//

import Factory
import NetworkKit
import Models

protocol PaginationEndpoint: Endpoint {
    var limit: Int { get set }
    var skip: Int { get set }
    var total: Int { get set }
}

struct DefaultPaginationEndpoint<T: Decodable & Sendable>: PaginationEndpoint {
    var total: Int
    let path: String
    var limit: Int = 20
    var skip: Int = .zero
    var queryParameters: [String: String]? = [:]
    typealias Response = T
}

@MainActor
protocol PaginationService {
    func fetch<E>(_ endpoint: E) async -> E.Response? where E: PaginationEndpoint
}

final class PaginationServiceLive: PaginationService {
    @Injected(\.networkService)
    private var networkService

    func fetch<E>(_ endpoint: E) async -> E.Response? where E : PaginationEndpoint {
        var ep = endpoint
        var params = ep.queryParameters ?? [:]
        params["limit"] = String(ep.limit)
        params["skip"] = String(ep.skip)
        ep.queryParameters = params
        let response = try? await networkService.execute(ep)
        return response
    }
}

extension Container {
    var paginationService: Factory<PaginationService> {
        Factory(self) { PaginationServiceLive() }
    }
}
