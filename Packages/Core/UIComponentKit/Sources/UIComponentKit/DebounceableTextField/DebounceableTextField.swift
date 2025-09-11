//
//  DebounceableTextField.swift
//  UIComponentKit
//
//  Created by Batuhan BARAN on 24.06.2025.
//

import SwiftUI

public struct DebounceableSearchTextField: View {
    @State private var searchText: String = ""
    @State private var debouncedText: String = ""
    @State private var searchTask: Task<Void, Never>?

    let placeholder: String
    let debounceInterval: TimeInterval
    let onSearchTextChanged: (String) -> Void

    public init(
        placeholder: String = "Search...",
        debounceInterval: TimeInterval = 0.8,
        onSearchTextChanged: @escaping (String) -> Void
    ) {
        self.placeholder = placeholder
        self.debounceInterval = debounceInterval
        self.onSearchTextChanged = onSearchTextChanged
    }

    public var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
                .padding(.leading, 8)

            TextField(placeholder, text: $searchText)
                .textFieldStyle(.plain)
                .onChange(of: searchText) { _, newValue in
                    handleTextChange(newValue)
                }

            if !searchText.isEmpty {
                Button(action: clearSearch) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
                .padding(.trailing, 8)
            }
        }
        .padding(.vertical, 8)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .onDisappear {
            searchTask?.cancel()
        }
    }

    private func handleTextChange(_ newValue: String) {
        // Cancel the previous task
        searchTask?.cancel()

        // Create a new debounced task
        searchTask = Task {
            do {
                // Simple approach: just sleep for the debounce interval
                try await Task.sleep(for: .seconds(debounceInterval))

                // Check if task was cancelled or text changed
                guard !Task.isCancelled, newValue == searchText else { return }

                // Update on main actor
                await MainActor.run {
                    debouncedText = newValue
                    onSearchTextChanged(newValue)
                }
            } catch {
                // Task was cancelled - this is expected behavior
            }
        }
    }

    private func clearSearch() {
        searchText = ""
        debouncedText = ""
        searchTask?.cancel()
        onSearchTextChanged("")
    }
}
