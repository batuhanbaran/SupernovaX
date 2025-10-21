//
//  AuthenticationServiceLive.swift
//  AuthenticationFeature
//
//  Created by Batuhan Baran on 25.09.2025.
//

import AuthenticationKit
import Factory
import Foundation
import NetworkKit
import Models
import UserKit

@available(iOS 17.0, *)
public struct AuthenticationServiceLive: AuthenticationService {

    @Injected(\.networkService) private var service

    public init() {}

    public func signIn(with model: SignInRequestModel) async throws -> SignInResponseModel {
        let user = try await service.execute(SignInEndpoint(model: model))
        let info = AppUserInformation.init(
            id: user.id ?? .zero,
            email: user.email ?? "",
            firstName: user.firstName ?? "",
            lastName: user.lastName ?? "",
            gender: .init(
                rawValue: user.gender ?? ""
            ) ?? .unknown
        )
        try await Container.shared.appUser()?.login(info: info, token: user.accessToken ?? "")
        return user
    }
}

