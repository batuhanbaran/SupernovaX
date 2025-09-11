//
//  HomeView.swift
//  SupernovaX
//
//  Created by Batuhan Baran on 10.09.2025.
//

import SwiftUI
import Factory
import FavoriteKit
import ProductListFeature

struct HomeView: View {
    @Environment(FavoriteManager.self) private var favoriteManager

    var body: some View {
        NavigationView {
            ProductListView()
            .navigationTitle("Products")
        }
    }
}

struct FavoritesView: View {
    @Environment(FavoriteManager.self) private var favoriteManager

    var body: some View {
        NavigationView {
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
}
