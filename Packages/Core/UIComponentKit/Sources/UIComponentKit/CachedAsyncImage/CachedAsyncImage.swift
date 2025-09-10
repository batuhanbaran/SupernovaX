//
//  CachedAsyncImage.swift
//  UIComponentKit
//
//  Created by Batuhan BARAN on 18.06.2025.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public struct CachedAsyncImage: View {
    let url: URL?

    @State private var imageState: ImageState = .loading

    public init(url: URL?) {
        self.url = url
    }

    public var body: some View {
        Group {
            switch imageState {
            case .loading:
                ProgressView()
            case .success(let data):
                #if canImport(UIKit)
                if let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    errorView
                }
                #elseif canImport(AppKit)
                if let nsImage = NSImage(data: data) {
                    Image(nsImage: nsImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    errorView
                }
                #endif
            case .failure:
                errorView
            }
        }
        .task(id: url) { // Re-run when URL changes
            await loadImage()
        }
    }

    private var errorView: some View {
        Image(systemName: "person.circle.fill")
            .resizable()
            .scaledToFit()
            .foregroundColor(.gray)
    }

    private func loadImage() async {
        guard let url = url else {
            imageState = .failure(.invalidURL)
            return
        }

        imageState = .loading

        do {
            let data = try await ImageCache.shared.loadImage(from: url)
            imageState = .success(data)
        } catch {
            imageState = .failure(.networkError(error))
        }
    }
}

// MARK: - ImageState Enum
private enum ImageState {
    case loading
    case success(Data)
    case failure(ImageError)
}

private enum ImageError: Error {
    case invalidURL
    case networkError(Error)
}

// MARK: - Enhanced ImageCache Actor
actor ImageCache {
    private var cache: [String: CacheEntry] = [:]
    private var ongoingRequests: [String: Task<Data, Error>] = [:]

    private let maxCacheSize: Int
    private let maxAge: TimeInterval

    static let shared = ImageCache()

    private init(maxCacheSize: Int = 100, maxAge: TimeInterval = 3600) { // 1 hour default
        self.maxCacheSize = maxCacheSize
        self.maxAge = maxAge
    }

    func loadImage(from url: URL) async throws -> Data {
        let key = url.absoluteString

        // Check if there's an ongoing request for this URL
        if let ongoingTask = ongoingRequests[key] {
            return try await ongoingTask.value
        }

        // Check cache first
        if let cachedData = getCachedData(for: key) {
            return cachedData
        }

        // Create new request task
        let task = Task<Data, Error> {
            do {
                let (data, response) = try await URLSession.shared.data(from: url)

                // Validate response
                guard let httpResponse = response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }

                // Store in cache
                self.store(data, for: key)

                return data
            } catch {
                // Remove failed request from ongoing requests
                self.removeOngoingRequest(for: key)
                throw error
            }
        }

        ongoingRequests[key] = task

        do {
            let data = try await task.value
            ongoingRequests.removeValue(forKey: key)
            return data
        } catch {
            ongoingRequests.removeValue(forKey: key)
            throw error
        }
    }

    private func getCachedData(for key: String) -> Data? {
        guard let entry = cache[key] else { return nil }

        // Check if cache entry is still valid
        if Date().timeIntervalSince(entry.timestamp) > maxAge {
            cache.removeValue(forKey: key)
            return nil
        }

        return entry.data
    }

    private func store(_ data: Data, for key: String) {
        // Remove oldest entries if cache is full
        if cache.count >= maxCacheSize {
            let oldestKey = cache.min { $0.value.timestamp < $1.value.timestamp }?.key
            if let keyToRemove = oldestKey {
                cache.removeValue(forKey: keyToRemove)
            }
        }

        cache[key] = CacheEntry(data: data, timestamp: Date())
    }

    private func removeOngoingRequest(for key: String) {
        ongoingRequests.removeValue(forKey: key)
    }

    // Public methods for cache management
    func clearCache() {
        cache.removeAll()
        ongoingRequests.removeAll()
    }

    func removeCachedImage(for url: URL) {
        cache.removeValue(forKey: url.absoluteString)
    }

    func getCacheSize() -> Int {
        return cache.count
    }

    func getMemoryFootprint() -> Int {
        return cache.values.reduce(0) { $0 + $1.data.count }
    }
}

// MARK: - CacheEntry
private struct CacheEntry {
    let data: Data
    let timestamp: Date
}
