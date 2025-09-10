//
//  LogLevel.swift
//  NetworkKit
//
//  Created by Batuhan Baran on 3.07.2025.
//

import Foundation

// MARK: - Log Level
public enum LogLevel: Int, Sendable {
    case none = 0
    case error = 1
    case info = 2
    case debug = 3
    case verbose = 4
    
    public var description: String {
        switch self {
        case .none: return "NONE"
        case .error: return "ERROR"
        case .info: return "INFO"
        case .debug: return "DEBUG"
        case .verbose: return "VERBOSE"
        }
    }
}

