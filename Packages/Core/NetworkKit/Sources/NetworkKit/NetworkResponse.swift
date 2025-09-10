//
//  NetworkResponse.swift
//  NetworkKit
//
//  Created by Batuhan Baran on 3.07.2025.
//

import Foundation

// MARK: - Network Response
public struct NetworkResponse: Sendable {
    public let data: Data
    public let urlResponse: URLResponse
    public let statusCode: Int
    
    public init(data: Data, urlResponse: URLResponse) {
        self.data = data
        self.urlResponse = urlResponse
        self.statusCode = (urlResponse as? HTTPURLResponse)?.statusCode ?? 0
    }
}