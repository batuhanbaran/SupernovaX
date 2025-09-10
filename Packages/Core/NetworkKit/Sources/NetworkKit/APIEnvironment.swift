//
//  APIEnvironment.swift
//  NetworkKit
//
//  Created by Batuhan Baran on 3.07.2025.
//

import Foundation

// MARK: - API Environment
public enum APIEnvironment: String, CaseIterable, Sendable {
    case development = "dev"
    case staging = "staging"
    case production = "prod"
    case testing = "test"
    
    public var displayName: String {
        switch self {
        case .development: return "Development"
        case .staging: return "Staging"
        case .production: return "Production"
        case .testing: return "Testing"
        }
    }
    
    public var baseURL: URL {
        switch self {
        case .development:
            return URL(string: "https://dev-api.example.com")!
        case .staging:
            return URL(string: "https://staging-api.example.com")!
        case .production:
            return URL(string: "https://api.example.com")!
        case .testing:
            return URL(string: "https://test-api.example.com")!
        }
    }
    
    public var timeout: TimeInterval {
        switch self {
        case .development, .testing:
            return 60.0 // Longer timeout for dev/testing
        case .staging:
            return 30.0
        case .production:
            return 15.0 // Shorter timeout for production
        }
    }
    
    public var retryCount: Int {
        switch self {
        case .development, .testing:
            return 1 // Less retries in dev to fail fast
        case .staging:
            return 2
        case .production:
            return 3 // More retries in production
        }
    }
    
    public var logLevel: LogLevel {
        switch self {
        case .development, .testing:
            return .verbose
        case .staging:
            return .info
        case .production:
            return .error
        }
    }
}

