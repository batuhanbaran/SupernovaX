//
//  SupernovaXApp.swift
//  SupernovaX
//
//  Created by Batuhan Baran on 10.09.2025.
//

import AppDestinationKit
import AuthenticationKit
import AuthenticationFeature
import Factory
import FavoriteKit
import FavoriteKitLive
import NavigatorUI
import NetworkRegistration
import SwiftUI
import TokenRegistration
import ProductListFeatureLive
import ProductDetailFeatureLive

@main
struct SupernovaXApp: App {
    var body: some Scene {
        WindowGroup {
            RootTabView()
        }
    }
}
