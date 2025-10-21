//
//  AuthenticationService.swift
//  AuthenticationKit
//
//  Created by Batuhan Baran on 25.09.2025.
//

import Models
import Factory

@available(iOS 17.0, *)
public protocol AuthenticationService: Sendable {
    func signIn(with model: SignInRequestModel) async throws -> SignInResponseModel
}

public extension Container {

    var authenticationService: Factory<AuthenticationService?> {
        self { nil }
    }
}
