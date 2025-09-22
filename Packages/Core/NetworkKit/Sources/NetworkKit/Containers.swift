//
//  Containers.swift
//  NetworkKit
//
//  Created by Batuhan Baran on 22.09.2025.
//

import Factory

// MARK: - Factory Dependency Container
public extension Container {
    var environmentManager: Factory<EnvironmentManager> {
        self { fatalError("EnvironmentManager not registered. Call NetworkRegistrations.register() first.") }.singleton
    }

    var networkConfiguration: Factory<NetworkConfiguration> {
        self { fatalError("NetworkConfiguration not registered. Call NetworkRegistrations.register() first.") }.cached
    }

    var networkService: Factory<NetworkServiceProtocol> {
        self { fatalError("NetworkService not registered. Call NetworkRegistrations.register() first.") }.cached
    }

    var authInterceptor: Factory<AuthenticationInterceptor> {
        self { fatalError("AuthenticationInterceptor not registered. Call NetworkRegistrations.register() first.") }.cached
    }

    var loggingInterceptor: Factory<LoggingInterceptor> {
        self { fatalError("LoggingInterceptor not registered. Call NetworkRegistrations.register() first.") }.cached
    }

}
