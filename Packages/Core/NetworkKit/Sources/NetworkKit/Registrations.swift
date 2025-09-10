//
//  NetworkError 2.swift
//  NetworkKit
//
//  Created by Batuhan BARAN on 1.07.2025.
//

import Foundation
import Factory

// MARK: - Factory Dependency Container
extension Container {
    public var environmentManager: Factory<EnvironmentManager> {
        self { EnvironmentManager() }
            .singleton
    }

    public var networkConfiguration: Factory<NetworkConfiguration> {
        self { Container.shared.environmentManager().getCurrentConfiguration() }
            .cached
    }

    public var networkService: Factory<NetworkServiceProtocol> {
        self {
            NetworkService(
                configuration: self.networkConfiguration(),
                urlSession: .shared,
                requestInterceptors: [
                    self.authInterceptor(),
                    self.loggingInterceptor()
                ],
                responseInterceptors: [
                    self.loggingInterceptor()
                ]
            )
        }
        .cached
    }
    
    public var authInterceptor: Factory<AuthenticationInterceptor> {
        self {
            AuthenticationInterceptor(tokenProvider: {
                return "your_access_token"
            })
        }
    }

    public var loggingInterceptor: Factory<LoggingInterceptor> {
        self { LoggingInterceptor() }
    }

}
