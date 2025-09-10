//
//  NetworkError 3.swift
//  NetworkKit
//
//  Created by Batuhan Baran on 3.07.2025.
//

import Foundation

// MARK: - Network Errors
public enum NetworkError: Error, Sendable {
    case invalidURL
    case noData
    case timeout
    case cancelled
    case decodingError(Error)
    case encodingError(Error)
    case httpError(Int, String)
    case networkError(Error)
    case unauthorized
    case forbidden
    case rateLimited
    case serverError
    
    public var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .timeout:
            return "Request timeout"
        case .cancelled:
            return "Request cancelled"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .encodingError(let error):
            return "Encoding error: \(error.localizedDescription)"
        case .httpError(let code, let message):
            return "HTTP error \(code): \(message)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .unauthorized:
            return "Unauthorized access"
        case .forbidden:
            return "Access forbidden"
        case .rateLimited:
            return "Rate limit exceeded"
        case .serverError:
            return "Server error"
        }
    }
}
