//
//  RootTabView.swift
//  SupernovaX
//
//  Created by Batuhan BARAN on 13.06.2025.
//

import FavoriteKitLive
import NavigatorUI
import SwiftUI

struct RootTabView : View {
    @SceneStorage("selectedTab") var selectedTab: RootTabs = .home
    @Environment(FavoriteManagerLive.self) private var favoriteManager

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(RootTabs.tabs) { tab in
                ManagedNavigationStack(scene: tab.sceneId) {
                    tab
                        .navigationDestination(for: SuperAppDestination.self) { destination in
                            destination
                        }
                }
                .badge(tab == .favorites ? favoriteManager.badge : .zero)
                .tabItem { Label(tab.title, systemImage: tab.image) }
                .tag(tab)
            }
        }
        .onNavigationReceive { (tab: RootTabs) in
            if tab == selectedTab {
                return .immediately
            }
            selectedTab = tab
            return .auto
        }
     }
}

public enum RootTabs: Int, Codable {
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

    public var id: String {
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
    
    var sceneId: String {
        switch self {
        case .home:
            "home"
        case .favorites:
            "favorites"
        case .settings:
            "settings"
        }
    }
}

extension RootTabs: NavigationDestination {
    public var body: some View {
        RootTabsViewBuilder(destination: self)
    }
}

public struct RootTabsViewBuilder: View {
    public let destination: RootTabs
    
    public init(destination: RootTabs) {
        self.destination = destination
    }

    public var body: some View {
        switch destination {
        case .home:
            HomeView()
                .navigationAutoReceive(SuperAppDestination.self)
        case .favorites:
            FavoritesView()
        case .settings:
            Text("Settings")
                .navigationTitle("Settings")
        }
    }
}

#Preview {
    RootTabView()
}
