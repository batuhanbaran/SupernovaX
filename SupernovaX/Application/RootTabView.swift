//
//  RootTabView.swift
//  SupernovaX
//
//  Created by Batuhan BARAN on 13.06.2025.
//

import AppDestinationKit
import AuthenticationKit
import AuthenticationFeature
import FavoriteKitLive
import NavigatorUI
import ProductDetailFeatureLive
import ProductListFeatureLive
import SwiftUI

struct RootTabView: View {
    let navigator: Navigator = .init(configuration: .init())

    @State var favoriteManager: FavoriteManagerLive = .init()
    @SceneStorage("selectedTab") var selectedTab: RootTabs = .home

    var body: some View {
        Group {
            if #available(iOS 18.0, *) {
                TabView(selection: $selectedTab) {
                    ForEach(RootTabs.tabs) { tab in
                        Tab(tab.title, systemImage: tab.image, value: tab) {
                            tabContent(for: tab)
                        }
                        .badge(tab == .favorites ? favoriteManager.badge : .zero)
                    }
                }
            } else {
                TabView(selection: $selectedTab) {
                    ForEach(RootTabs.tabs) { tab in
                        tabContent(for: tab)
                            .tabItem {
                                Label(tab.title, systemImage: tab.image)
                            }
                            .tag(tab)
                            .badge(tab == .favorites ? favoriteManager.badge : .zero)
                    }
                }
            }
        }
        .environment(favoriteManager)
        .onNavigationReceive { (tab: RootTabs) in
            if tab == selectedTab {
                return .immediately
            }
            selectedTab = tab
            return .auto
        }
        .onNavigationProvidedView(AppDestinations.self) { destination in
            switch destination {
            case .productList:
                ProductListView()
            case .productDetail(let productId):
                ProductDetailView(productId: productId)
            case .authentication:
                AuthenticationDestinationView()
            }
        }
        .onNavigationReceive(assign: $selectedTab)
        .navigationRoot(navigator)
    }

    @ViewBuilder
    private func tabContent(for tab: RootTabs) -> some View {
        ManagedNavigationStack {
            tab
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

public enum RootTabs: Int, Codable {
    case home
    case favorites
    case settings
    case account
}

extension RootTabs: Identifiable {

    static var tabs: [RootTabs] {
        [.home, .favorites, .settings, .account]
    }

    static var sidebar: [RootTabs] {
        [.home, .favorites, .settings, .account]
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
        case .account:
            "Account"
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
        case .account:
            "person"
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
        case .account:
            "account"
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
        case .favorites:
            FavoritesView()
        case .settings:
            SettingsView()
        case .account:
            AccountView()
        }
    }
}

#Preview {
    RootTabView()
}
