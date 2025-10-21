//
//  SignInEndpoint.swift
//  AuthenticationKit
//
//  Created by Batuhan Baran on 25.09.2025.
//

import Models
import NetworkKit

public struct SignInEndpoint: Endpoint {
    public var queryParameters: [String : String]?
    
    public var path: String = "auth/login"
    public var httpMethod: HTTPMethod = .POST
    public var body: (any Encodable & Sendable)?

    public typealias Response = SignInResponseModel

    public init(model: SignInRequestModel) {
        self.body = model
    }
}
