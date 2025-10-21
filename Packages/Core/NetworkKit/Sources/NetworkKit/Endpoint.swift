//
//  Endpoint.swift
//  NetworkKit
//
//  Created by Batuhan BARAN on 2.06.2025.
//

import Foundation

// MARK: - Enhanced Endpoint Protocol
public protocol Endpoint: Sendable {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String]? { get set }
    var body: (Encodable & Sendable)? { get }
    var timeout: TimeInterval? { get }
    var requiresAuthentication: Bool { get }
    
    associatedtype Response: Decodable & Sendable
    
    func urlRequest() throws -> URLRequest
}

// MARK: - Default Endpoint Implementation
public extension Endpoint {
    var baseURL: URL {
        URL(string: "https://dummyjson.com/")!
    }
    
    var httpMethod: HTTPMethod {
        .GET
    }
    
    var headers: [String: String] {
        ["Content-Type": "application/json"]
    }
    
    var queryParameters: [String: String]? {
        nil
    }
    
    var body: (Encodable & Sendable)? {
        nil
    }
    
    var timeout: TimeInterval? {
        nil
    }
    
    var requiresAuthentication: Bool {
        false
    }
    
    func urlRequest() throws -> URLRequest {
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true)
        
        // Add query parameters
        if let queryParameters = queryParameters, !queryParameters.isEmpty {
            components?.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        
        if let timeout = timeout {
            request.timeoutInterval = timeout
        }
        
        // Add body for methods that support it
        if let body = body, [.POST, .PUT, .PATCH].contains(httpMethod) {
            do {
                let encoder = JSONEncoder()
                encoder.keyEncodingStrategy = .convertToSnakeCase
                encoder.dateEncodingStrategy = .iso8601
                request.httpBody = try encoder.encode(AnyEncodable(body))
            } catch {
                throw NetworkError.encodingError(error)
            }
        }
        
        return request
    }
}

// MARK: - Request Interceptor Protocol
public protocol RequestInterceptor: Sendable {
    func intercept(_ request: URLRequest) async throws -> URLRequest
}

// MARK: - Response Interceptor Protocol
public protocol ResponseInterceptor: Sendable {
    func intercept(_ response: NetworkResponse) async throws -> NetworkResponse
}

// MARK: - Type-Erased Encodable Wrapper
private struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    
    init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }
    
    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}

// MARK: - Authentication Interceptor Example
public struct AuthenticationInterceptor: RequestInterceptor {
    private let tokenProvider: @Sendable () async throws -> String
    
    public init(tokenProvider: @Sendable @escaping () async throws -> String) {
        self.tokenProvider = tokenProvider
    }
    
    public func intercept(_ request: URLRequest) async throws -> URLRequest {
        var modifiedRequest = request
        let token = try await tokenProvider()
        modifiedRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return modifiedRequest
    }
}

// MARK: - Logging Interceptor Example
public struct LoggingInterceptor: RequestInterceptor, ResponseInterceptor {
    private let logger: @Sendable (String) -> Void

    public init(logger: @escaping @Sendable (String) -> Void = { print($0) }) {
        self.logger = logger
    }

    public func intercept(_ request: URLRequest) async throws -> URLRequest {
        logger("🚀 Request: \(request.httpMethod ?? "GET") \(request.url?.absoluteString ?? "Unknown URL")")
        return request
    }

    public func intercept(_ response: NetworkResponse) async throws -> NetworkResponse {
        logger("✅ Response: \(response.statusCode) - \(response.data.count) bytes")
        return response
    }
}
