//
//  AppUser.swift
//  UserKit
//
//  Created by Batuhan Baran on 1.10.2025.
//

import Factory
import Foundation

public protocol AppUser: Sendable {
    var isLoggedIn: Bool { get async }
    var info: AppUserInformation? { get async }
    var stateChanges: AsyncStream<UserStateChange> { get }
    func login(info: AppUserInformation, token: String) async throws
    func logout() async throws
}

public extension Container {
    var appUser: Factory<AppUser?> {
        self { nil }
            .scope(.singleton)
    }
}
