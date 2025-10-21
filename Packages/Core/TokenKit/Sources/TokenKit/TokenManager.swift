//
//  TokenManager.swift
//  TokenKit
//
//  Created by Batuhan Baran on 1.10.2025.
//

import Factory
import Foundation

public protocol TokenManager: Sendable {
    func save(_ token: String) async throws
    func get() async -> String?
    func delete() async throws
    func clearAll() async throws
    func isValid() async -> Bool
    func getUserClaims() async -> UserClaims?
}

public extension Container {
    var tokenManager: Factory<TokenManager?> {
        self { nil }
            .scope(.singleton)
    }
}
