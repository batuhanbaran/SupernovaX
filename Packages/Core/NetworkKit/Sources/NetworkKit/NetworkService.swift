//
//  NetworkService 2.swift
//  NetworkKit
//
//  Created by Batuhan Baran on 3.07.2025.
//

import Foundation

// MARK: - Network Service Protocol
public protocol NetworkServiceProtocol: Sendable {
    func execute<T: Endpoint>(_ request: T) async throws -> T.Response
}

// MARK: - Network Service Implementation
public final class NetworkService: NetworkServiceProtocol, @unchecked Sendable {
    private let urlSession: URLSession
    private let configuration: NetworkConfiguration
    private let jsonDecoder: JSONDecoder
    private let requestInterceptors: [RequestInterceptor]
    private let responseInterceptors: [ResponseInterceptor]
    
    public init(
        configuration: NetworkConfiguration,
        urlSession: URLSession = .shared,
        requestInterceptors: [RequestInterceptor] = [],
        responseInterceptors: [ResponseInterceptor] = []
    ) {
        self.configuration = configuration
        self.requestInterceptors = requestInterceptors
        self.responseInterceptors = responseInterceptors

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = configuration.timeout
        sessionConfig.timeoutIntervalForResource = configuration.timeout * 2
        self.urlSession = URLSession(configuration: sessionConfig)
        
        self.jsonDecoder = JSONDecoder()
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        self.jsonDecoder.dateDecodingStrategy = .iso8601
    }
    
    // MARK: - Execute Method
    public func execute<T: Endpoint>(_ request: T) async throws -> T.Response {
        let urlRequest = try request.urlRequest()
        
        let networkResponse = try await withRetry(maxAttempts: configuration.retryCount) {
            try await self.performRequest(urlRequest)
        }
        
        do {
            let decodedResponse = try jsonDecoder.decode(T.Response.self, from: networkResponse.data)
            return decodedResponse
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    // MARK: - Private Methods
    private func performRequest(_ urlRequest: URLRequest) async throws -> NetworkResponse {
        var interceptedRequest = urlRequest

        for interceptor in requestInterceptors {
            interceptedRequest = try await interceptor.intercept(interceptedRequest)
        }
        
        do {
            let (data, response) = try await urlSession.data(for: interceptedRequest)
            var networkResponse = NetworkResponse(data: data, urlResponse: response)
            
            for interceptor in responseInterceptors {
                networkResponse = try await interceptor.intercept(networkResponse)
            }
            
            try validateResponse(networkResponse)
            return networkResponse
            
        } catch let error as URLError {
            throw mapURLError(error)
        } catch let networkError as NetworkError {
            throw networkError
        } catch {
            throw NetworkError.networkError(error)
        }
    }
    
    private func validateResponse(_ response: NetworkResponse) throws {
        switch response.statusCode {
        case 200...299:
            return
        case 401:
            throw NetworkError.unauthorized
        case 403:
            throw NetworkError.forbidden
        case 429:
            throw NetworkError.rateLimited
        case 500...599:
            throw NetworkError.serverError
        default:
            let message = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
            throw NetworkError.httpError(response.statusCode, message)
        }
    }
    
    private func mapURLError(_ error: URLError) -> NetworkError {
        switch error.code {
        case .timedOut:
            return .timeout
        case .cancelled:
            return .cancelled
        case .notConnectedToInternet, .networkConnectionLost:
            return .networkError(error)
        default:
            return .networkError(error)
        }
    }
    
    private func withRetry<T: Sendable>(
        maxAttempts: Int,
        operation: @Sendable () async throws -> T
    ) async throws -> T {
        var lastError: Error?
        
        for attempt in 1...maxAttempts {
            do {
                return try await operation()
            } catch {
                lastError = error
                
                // Don't retry certain errors
                if case NetworkError.decodingError = error,
                   case NetworkError.invalidURL = error,
                   case NetworkError.unauthorized = error,
                   case NetworkError.forbidden = error {
                    throw error
                }
                
                if attempt < maxAttempts {
                    let delay = calculateBackoffDelay(attempt: attempt)
                    try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                }
            }
        }
        
        throw lastError ?? NetworkError.networkError(NSError(domain: "UnknownError", code: -1))
    }
    
    private func calculateBackoffDelay(attempt: Int) -> TimeInterval {
        // Exponential backoff with jitter
        let baseDelay = configuration.retryDelay
        let exponentialDelay = baseDelay * pow(2.0, Double(attempt - 1))
        let jitter = Double.random(in: 0...0.1) * exponentialDelay
        return min(exponentialDelay + jitter, 30.0) // Cap at 30 seconds
    }
}
