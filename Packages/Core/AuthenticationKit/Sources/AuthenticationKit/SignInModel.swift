//
//  SignInModel.swift
//  AuthenticationKit
//
//  Created by Batuhan Baran on 25.09.2025.
//

import Models

public enum Gender: String, Sendable, Decodable {
    case male = "male"
    case female = "female"
    case unknown
}

public struct SignInRequestModel: Sendable, Encodable {
    let username: String
    let password: String

    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

public struct SignInResponseModel: StandardModel {
    public let accessToken: String?
    public let password: String?
    public let id: Int?
    public let email: String?
    public let firstName: String?
    public let lastName: String?
    public let gender: String?

    public init(
        accessToken: String?,
        password: String?,
        id: Int?,
        email: String?,
        firstName: String?,
        lastName: String?,
        gender: String?
    ) {
        self.accessToken = accessToken
        self.password = password
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
    }
}
