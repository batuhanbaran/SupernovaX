//
//  AppUserInformation.swift
//  UserKit
//
//  Created by Batuhan Baran on 2.10.2025.
//

import Foundation

public enum Gender: String, Sendable {
    case male = "male"
    case female = "female"
    case unknown
}

public struct AppUserInformation: Sendable {
    public let id: Int
    public let email: String
    public let firstName: String
    public let lastName: String
    public let gender: Gender

    public init(
        id: Int,
        email: String,
        firstName: String,
        lastName: String,
        gender: Gender
    ) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
    }
}
