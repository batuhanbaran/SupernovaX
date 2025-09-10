//
//  EnvironmentManager.swift
//  NetworkKit
//
//  Created by Batuhan Baran on 3.07.2025.
//

import SwiftUI
import Factory

// MARK: - Environment Manager
public final class EnvironmentManager: ObservableObject {
    @Published public private(set) var currentEnvironment: APIEnvironment
    
    private static let environmentKey = "APIEnvironment"
    private let lock = NSLock()
    
    nonisolated(unsafe) public static let shared = EnvironmentManager()

    public init() {
        // Load saved environment or default to appropriate environment based on build configuration
        #if DEBUG
        let defaultEnvironment = APIEnvironment.development
        #else
        let defaultEnvironment = APIEnvironment.production
        #endif
        
        if let savedEnvironment = UserDefaults.standard.string(forKey: Self.environmentKey),
           let environment = APIEnvironment(rawValue: savedEnvironment) {
            self.currentEnvironment = environment
        } else {
            self.currentEnvironment = defaultEnvironment
        }
    }
    
    @MainActor
    public func setEnvironment(_ environment: APIEnvironment) {
        currentEnvironment = environment
        UserDefaults.standard.set(environment.rawValue, forKey: Self.environmentKey)
        
        // Trigger Factory container reset to use new configuration
        Container.shared.reset()
        
        // Log environment change
        print("🌍 API Environment changed to: \(environment.displayName)")
        print("📍 Base URL: \(environment.baseURL.absoluteString)")
    }
    
    public func getCurrentConfiguration() -> NetworkConfiguration {
        lock.lock()
        defer { lock.unlock() }
        return NetworkConfiguration(environment: currentEnvironment)
    }
    
    public func getCurrentEnvironment() -> APIEnvironment {
        lock.lock()
        defer { lock.unlock() }
        return currentEnvironment
    }
}
