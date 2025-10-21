//
//  TokenManager.swift
//  UserKit
//
//  Created by Batuhan Baran on 1.10.2025.
//

import Foundation
import TokenKit
import KeychainAccess
import JWTDecode

public actor TokenManagerLive: TokenManager {
    private let keychain: Keychain
    private let tokenKey = "jwt_token"

    public init(service: String = "com.batuhanbaran.SupernovaX") {
        self.keychain = Keychain(service: service)
            .accessibility(.afterFirstUnlock)
            .synchronizable(false) // iCloud senkronizasyonunu kapat
    }

    public func save(_ token: String) async throws {
        do {
            try keychain.set(token, key: tokenKey)
        } catch {
            throw TokenError.saveFailed(underlying: error)
        }
    }

    public func get() async -> String? {
        try? keychain.get(tokenKey)
    }

    public func delete() async throws {
        do {
            try keychain.remove(tokenKey)
        } catch {
            throw TokenError.deleteFailed(underlying: error)
        }
    }
    
    /// Tüm keychain verilerini temizler (logout için)
    public func clearAll() async throws {
        do {
            try keychain.removeAll()
        } catch {
            throw TokenError.deleteFailed(underlying: error)
        }
    }

    public func isValid() async -> Bool {
        guard let jwt = try? getDecodedToken() else {
            return false
        }

        guard let expiresAt = jwt.expiresAt else {
            return false
        }

        return expiresAt.timeIntervalSinceNow > 0
    }

    public func getUserClaims() async -> UserClaims? {
        guard let jwt = try? getDecodedToken() else {
            return nil
        }

        let userId = jwt.claim(name: "id").integer
        let email = jwt.claim(name: "email").string
        let firstName = jwt.claim(name: "firstName").string
        let lastName = jwt.claim(name: "lastName").string
        let gender = jwt.claim(name: "gender").string

        // Tüm claim'ler nil ise nil dön
        guard userId != nil || email != nil || firstName != nil ||
              lastName != nil || gender != nil else {
            return nil
        }

        return UserClaims(
            userId: userId,
            email: email,
            firstName: firstName,
            lastName: lastName,
            gender: gender
        )
    }

    // MARK: - Private Helpers

    private func getDecodedToken() throws -> JWT {
        guard let token = try keychain.get(tokenKey) else {
            throw TokenError.tokenNotFound
        }

        do {
            return try decode(jwt: token)
        } catch {
            throw TokenError.decodeFailed(underlying: error)
        }
    }
}
