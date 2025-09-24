//
//  HomeView.swift
//  SupernovaX
//
//  Created by Batuhan Baran on 10.09.2025.
//

import SwiftUI
import Factory
import FavoriteKitLive
import ProductListFeature
import NavigatorUI

struct HomeView: View {
    @Environment(\.navigator) private var navigator

    var body: some View {
        ProductListView()
            .navigationTitle("Products")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        navigator.openSuperAppSheet()
                    }) {
                        Image(systemName: "apps.iphone")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.blue)
                    }
                }
            }
    }
}

struct FavoritesView: View {
    @Environment(FavoriteManagerLive.self) private var favoriteManager

    var body: some View {
        List {
            ForEach(favoriteManager.favorites) { favorite in
                Text(favorite.id)
            }
            .onDelete { indexSet in
                Task {
                    await favoriteManager.remove(at: indexSet)
                }
            }
        }
        .navigationTitle("Favorites (\(favoriteManager.badge))")
    }
}
