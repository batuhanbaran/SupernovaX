//
//  RootTabView.swift
//  DummyUser
//
//  Created by Batuhan BARAN on 13.06.2025.
//

import FavoriteKit
import NavigatorUI
import SwiftUI

struct RootTabView : View {
    @SceneStorage("selectedTab") var selectedTab: RootTabs = .home
    @Environment(FavoriteManager.self) private var favoriteManager

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(RootTabs.tabs) { tab in
                tab
                    .badge(tab == .favorites ? favoriteManager.badge : .zero)
                    .tabItem { Label(tab.title, systemImage: tab.image) }
                    .tag(tab)
            }
        }
     }
}

enum RootTabs: Int, Codable {
    case home
    case favorites
    case settings
}

extension RootTabs: Identifiable {

    static var tabs: [RootTabs] {
        [.home, .favorites, .settings]
    }

    static var sidebar: [RootTabs] {
        [.home, .favorites, .settings]
    }

    var id: String {
        "\(self)"
    }

    var title: String {
        switch self {
        case .home:
            "Home"
        case .favorites:
            "Favorites"
        case .settings:
            "Settings"
        }
    }

    var image: String {
        switch self {
        case .home:
            "house"
        case .favorites:
            "heart"
        case .settings:
            "gear"
        }
    }
}

extension RootTabs: NavigationDestination {
    var body: some View {
        RootTabsViewBuilder(destination: self)
    }
}

private struct RootTabsViewBuilder: View {
    let destination: RootTabs

    var body: some View {
        switch destination {
        case .home:
            HomeView()
        case .favorites:
            FavoritesView()
        case .settings:
            Text("Settings")
        }
    }
}

#Preview {
    RootTabView()
}
