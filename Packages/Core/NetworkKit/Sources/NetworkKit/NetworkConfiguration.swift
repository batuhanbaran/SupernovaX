//
//  NetworkConfiguration.swift
//  NetworkKit
//
//  Created by Batuhan Baran on 3.07.2025.
//

import Foundation

// MARK: - Network Configuration
public struct NetworkConfiguration: Sendable {
    public let environment: APIEnvironment
    public let baseURL: URL
    public let defaultHeaders: [String: String]
    public let timeout: TimeInterval
    public let retryCount: Int
    public let retryDelay: TimeInterval
    public let logLevel: LogLevel
    public let enableSSLPinning: Bool
    public let apiVersion: String
    
    public init(
        environment: APIEnvironment,
        customBaseURL: URL? = nil,
        defaultHeaders: [String: String] = [:],
        timeout: TimeInterval? = nil,
        retryCount: Int? = nil,
        retryDelay: TimeInterval = 1.0,
        logLevel: LogLevel? = nil,
        enableSSLPinning: Bool = false,
        apiVersion: String = "v1"
    ) {
        self.environment = environment
        self.baseURL = customBaseURL ?? environment.baseURL
        self.timeout = timeout ?? environment.timeout
        self.retryCount = retryCount ?? environment.retryCount
        self.retryDelay = retryDelay
        self.logLevel = logLevel ?? environment.logLevel
        self.enableSSLPinning = enableSSLPinning
        self.apiVersion = apiVersion
        
        // Merge environment-specific headers with custom headers
        var headers = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "X-API-Version": apiVersion,
            "X-Environment": environment.rawValue
        ]
        
        // Add environment-specific headers
        switch environment {
        case .development, .testing:
            headers["X-Debug"] = "true"
            headers["X-Request-ID"] = UUID().uuidString
        case .staging:
            headers["X-Staging"] = "true"
        case .production:
            headers["X-Production"] = "true"
        }
        
        // Override with custom headers
        for (key, value) in defaultHeaders {
            headers[key] = value
        }
        
        self.defaultHeaders = headers
    }
    
    // Convenience initializers for each environment
    public static func development(
        customHeaders: [String: String] = [:],
        apiVersion: String = "v1"
    ) -> NetworkConfiguration {
        return NetworkConfiguration(
            environment: .development,
            defaultHeaders: customHeaders,
            apiVersion: apiVersion
        )
    }
    
    public static func staging(
        customHeaders: [String: String] = [:],
        apiVersion: String = "v1"
    ) -> NetworkConfiguration {
        return NetworkConfiguration(
            environment: .staging,
            defaultHeaders: customHeaders,
            apiVersion: apiVersion
        )
    }
    
    public static func production(
        customHeaders: [String: String] = [:],
        enableSSLPinning: Bool = true,
        apiVersion: String = "v1"
    ) -> NetworkConfiguration {
        return NetworkConfiguration(
            environment: .production,
            defaultHeaders: customHeaders,
            enableSSLPinning: enableSSLPinning,
            apiVersion: apiVersion
        )
    }
    
    public static func testing(
        customBaseURL: URL? = nil,
        apiVersion: String = "v1"
    ) -> NetworkConfiguration {
        return NetworkConfiguration(
            environment: .testing,
            customBaseURL: customBaseURL,
            apiVersion: apiVersion
        )
    }
}

