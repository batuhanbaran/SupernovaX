//
//  SupernovaXApp.swift
//  SupernovaX
//
//  Created by Batuhan Baran on 10.09.2025.
//

import Factory
import FavoriteKit
import FavoriteKitLive
import NetworkRegistration
import NavigatorUI
import SwiftUI

@main
struct SupernovaXApp: App {
    var body: some Scene {
        WindowGroup {
            ApplicationRootView()
        }
    }
}

struct ApplicationRootView: View {

    @State private var favoriteManager = FavoriteManagerLive()

    init() {
        autoRegister()
    }

    var body: some View {
        applicationView()
    }

    func applicationNavigator() -> Navigator {
        let configuration: NavigationConfiguration = .init(
            restorationKey: nil,
            executionDelay: 0.4,
            verbosity: .info
        )
        return Navigator(configuration: configuration)
    }

    func applicationView() -> some View {
        RootTabView()
            .environment(\.navigator, applicationNavigator())
            .environment(favoriteManager)
    }

    func autoRegister() {
        Container.shared.autoRegister()
    }
}

// MARK: - Navigation Extensions
extension Navigator {
    /// Navigate to a specific tab using Navigator's send pattern
    @MainActor
    func navigateToTab(_ tab: RootTabs) {
        send(tab)
    }
    
    /// Navigate to a specific tab with a destination
    @MainActor
    func navigateToTab(_ tab: RootTabs, destination: SuperAppDestination) {
        send(tab, destination)
    }
    
    /// Open SuperApp sheet
    @MainActor
    func openSuperAppSheet() {
        navigate(to: SuperAppDestination.superAppSheet)
    }

    @MainActor
    func navigateTodoX() {
        navigate(to: SuperAppDestination.todoX)
    }
}
