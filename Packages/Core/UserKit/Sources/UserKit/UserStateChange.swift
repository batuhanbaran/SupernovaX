//
//  UserStateChange.swift
//  UserKit
//
//  Created by Batuhan Baran on 21.10.2025.
//


// MARK: - User State Change Event
public struct UserStateChange: Sendable {
    public let info: AppUserInformation?
    public let isLoggedIn: Bool

    public init(info: AppUserInformation?, isLoggedIn: Bool) {
        self.info = info
        self.isLoggedIn = isLoggedIn
    }
}
