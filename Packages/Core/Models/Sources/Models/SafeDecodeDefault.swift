//
//  SafeDecodeDefault.swift
//  Models
//
//  Created by Batuhan Baran on 3.07.2025.
//

import Foundation

// MARK: - SafeDecodeDefault - Automatic and Custom Defaults
/// A flexible SafeDecode implementation that provides automatic defaults for common types
/// and allows custom defaults when needed
@propertyWrapper
public struct SafeDecodeDefault<T: Codable & Sendable>: Codable, Sendable {
    private var value: T
    private let defaultValue: T
    
    public var wrappedValue: T {
        get { value }
        set { value = newValue }
    }
    
    public init(_ defaultValue: T) {
        self.defaultValue = defaultValue
        self.value = defaultValue
    }
    
    public init() {
        guard let autoDefault = Self.getAutomaticDefault() as? T else {
            fatalError("SafeDecodeDefault requires either a custom default value or the type must have an automatic default")
        }
        self.defaultValue = autoDefault
        self.value = autoDefault
    }
    
    public init(from decoder: Decoder) throws {
        // Use the automatic default for decoding
        guard let autoDefault = Self.getAutomaticDefault() as? T else {
            fatalError("Cannot determine default value for type \(T.self)")
        }
        self.defaultValue = autoDefault
        
        let container = try decoder.singleValueContainer()
        
        do {
            self.value = try container.decode(T.self)
        } catch {
            self.value = self.defaultValue
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
    
    private static func getAutomaticDefault() -> Any? {
        switch T.self {
        case is String.Type:
            return ""
        case is Int.Type:
            return 0
        case is Double.Type:
            return 0.0
        case is Float.Type:
            return 0.0
        case is Bool.Type:
            return false
        case is Array<Any>.Type:
            return []
        default:
            return nil
        }
    }
}
