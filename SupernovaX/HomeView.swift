//
//  HomeView.swift
//  SupernovaX
//
//  Created by Batuhan Baran on 10.09.2025.
//

import SwiftUI
import Factory
import FavoriteKit

struct HomeView: View {
    @Environment(FavoriteManager.self) private var favoriteManager

    var body: some View {
        NavigationView {
            VStack {
                Text("Home View")
                Button("Add Random Favorite") {
                    Task {
                        await favoriteManager.add(.random())
                    }
                }
            }
            .navigationTitle("Home")
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
