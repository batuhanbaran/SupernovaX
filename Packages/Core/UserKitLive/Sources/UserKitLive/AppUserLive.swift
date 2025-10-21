//
//  AppUserLive.swift
//  UserKitLive
//
//  Created by Batuhan Baran on 1.10.2025.
//

import UserKit
import Factory
import Foundation
import TokenKit
import JWTDecode

// MARK: - AppUserLive
public actor AppUserLive: AppUser {
    public private(set) var info: AppUserInformation?
    public private(set) var isLoggedIn: Bool = false

    private let stateContinuation: AsyncStream<UserStateChange>.Continuation
    public nonisolated let stateChanges: AsyncStream<UserStateChange>

    public init() {
        var continuation: AsyncStream<UserStateChange>.Continuation!
        self.stateChanges = AsyncStream(bufferingPolicy: .bufferingNewest(1)) { cont in
            continuation = cont
        }
        self.stateContinuation = continuation

        Task {
            try await restoreSession()
        }
    }

    deinit {
        stateContinuation.finish()
    }

    public func login(info: AppUserInformation, token: String) async throws {
        try await Container.shared.tokenManager()?.save(token)
        self.info = info
        self.isLoggedIn = true
        emitStateChange()
    }

    public func logout() async throws {
        try await Container.shared.tokenManager()?.delete()
        self.info = nil
        self.isLoggedIn = false
        emitStateChange()
    }

    func restoreSession() async throws {
        let isValid = await Container.shared.tokenManager()?.isValid() ?? false
        guard isValid else {
            self.info = nil
            self.isLoggedIn = false
            emitStateChange()
            return
        }

        guard let claims = await Container.shared.tokenManager()?.getUserClaims(),
              let userId = claims.userId,
              let email = claims.email,
              let firstName = claims.firstName,
              let lastName = claims.lastName,
              let genderString = claims.gender,
              let gender = Gender(rawValue: genderString) else {
            try await logout()
            return
        }

        self.info = AppUserInformation(
            id: userId,
            email: email,
            firstName: firstName,
            lastName: lastName,
            gender: gender
        )
        self.isLoggedIn = true
        emitStateChange()
    }

    func getToken() async -> String? {
        await Container.shared.tokenManager()?.get()
    }

    private func emitStateChange() {
        let change = UserStateChange(info: info, isLoggedIn: isLoggedIn)
        print("📡 AppUserLive emitting state change - isLoggedIn: \(isLoggedIn), userInfo: \(info?.firstName ?? "nil")")
        stateContinuation.yield(change)
    }
}
