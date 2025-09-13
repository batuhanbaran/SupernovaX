//
//  SupernovaXApp.swift
//  SupernovaX
//
//  Created by Batuhan Baran on 10.09.2025.
//

import Factory
import FavoriteKit
import FavoriteKitLive
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
            .environment(\.favoriteManager, FavoriteManagerFactory.makeDefault())
    }

    func autoRegister() {
        Container.shared.autoRegister()
    }
}
