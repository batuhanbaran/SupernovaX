//
//  HTTPMethod.swift
//  NetworkKit
//
//  Created by Batuhan Baran on 3.07.2025.
//

import Foundation

// MARK: - HTTP Method
public enum HTTPMethod: String, Sendable {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
    case PATCH = "PATCH"
}
