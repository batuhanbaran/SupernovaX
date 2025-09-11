//
//  FavoriteButton.swift
//  ProductListUI
//
//  Created by Batuhan Baran on 11.09.2025.
//

import FavoriteKit
import SwiftUI

// MARK: - Favorite Button
public struct FavoriteButton: View {
    private let id: String

    @State private var isFavorite: Bool = false
    @State private var pressed = false
    @Environment(FavoriteManager.self) private var favoriteManager

    public init(id: String) {
        self.id = id
    }

    public var body: some View {
        Button {
            pressed = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                pressed = false
            }
            isFavorite.toggle()

            Task {
                await favoriteManager.toggle(.init(id: id))
            }
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(isFavorite ? .red : .primary)
                .padding(8)
                .background(.ultraThinMaterial, in: Circle())
                .overlay(Circle().stroke(Color.black.opacity(0.06), lineWidth: 0.5))
        }
        .buttonStyle(.plain)
        .scaleEffect(pressed ? 0.9 : 1.0)
        .animation(.spring(response: 0.25, dampingFraction: 0.7), value: pressed)
        .accessibilityLabel(isFavorite ? "Remove from favorites" : "Add to favorites")
        .task {
            isFavorite = await favoriteManager.isFavorite(.init(id: id))
        }
    }
}
