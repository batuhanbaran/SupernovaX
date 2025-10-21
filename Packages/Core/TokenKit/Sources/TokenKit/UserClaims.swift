//
//  UserClaims.swift
//  TokenKit
//
//  Created by Batuhan Baran on 2.10.2025.
//

import Foundation

public struct UserClaims: Sendable {
    public let userId: Int?
    public let email: String?
    public let firstName: String?
    public let lastName: String?
    public let gender: String?

    public init(
        userId: Int? = nil,
        email: String? = nil,
        firstName: String? = nil,
        lastName: String? = nil,
        gender: String? = nil
    ) {
        self.userId = userId
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
    }
}
