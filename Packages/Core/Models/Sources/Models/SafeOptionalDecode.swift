////
////  SafeOptionalDecode.swift
////  Models
////
////  Created by Batuhan Baran on 3.07.2025.
////
//
//import Foundation
//
//// MARK: - SafeOptionalDecode Property Wrapper
///// A property wrapper that provides safe optional decoding, returning nil when decoding fails
//@propertyWrapper
//public struct SafeOptionalDecode<T: Codable & Sendable & Hashable>: StandardModel {
//    private var value: T?
//    
//    public var wrappedValue: T? {
//        get { value }
//        set { value = newValue }
//    }
//    
//    public init(wrappedValue: T?) {
//        self.value = wrappedValue
//    }
//    
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        
//        do {
//            if container.decodeNil() {
//                self.value = nil
//            } else {
//                self.value = try container.decode(T.self)
//            }
//        } catch {
//            self.value = nil
//        }
//    }
//    
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encode(value)
//    }
//}
