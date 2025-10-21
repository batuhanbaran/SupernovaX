//
//  HomeView.swift
//  SupernovaX
//
//  Created by Batuhan Baran on 10.09.2025.
//

import AppDestinationKit
import SwiftUI
import Factory
import FavoriteKitLive
import ProductListFeatureLive
import AuthenticationKit
import AuthenticationFeature
import UserKit
import UserKitLive
import NavigatorUI

struct HomeView: View {
    @Environment(\.navigator) private var navigator

    var body: some View {
        ProductListView()
            .navigationTitle("Products")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        navigator.navigate(to: SuperAppDestination.superAppSheet)
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
    @Environment(\.navigator) private var navigator

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

struct SettingsView: View {
    @Environment(\.navigator) var navigator

    var body: some View {
        List {
            Section("App Info") {
                Text("Version 1.0.0")
                Text("Navigator Demo")
            }
        }
        .navigationTitle("Settings")
    }
}

struct AccountView: View {
    @State private var userState: UserState = .notLoggedIn

    enum UserState {
        case notLoggedIn
        case loggedIn(AppUserInformation)
    }

    @Environment(\.navigator) var navigator
    @Environment(FavoriteManagerLive.self) var favoriteManager

    @State private var userInfo: AppUserInformation?
    @State private var isLoggedIn = false
    @State private var observationTask: Task<Void, Never>?

    @Injected(\.appUser)
    var appUser

    var body: some View {
        Form {
            switch userState {
            case .notLoggedIn:
                signInSection

            case .loggedIn(let info):
                userInfoSection(info)
                logoutSection
            }
        }
        .navigationTitle("Account")
        .onAppear {
            startObserving()
        }
        .onDisappear {
            observationTask?.cancel()
            observationTask = nil
        }
    }

    private var signInSection: some View {
        Section {
            Button("Sign In") {
                navigator.navigate(to: AppDestinations.authentication, method: .managedSheet)
            }
        }
    }

    private func userInfoSection(_ info: AppUserInformation) -> some View {
        Section("Name / Surname") {
            Text("\(info.firstName) / \(info.lastName)")
        }
    }

    private var logoutSection: some View {
        Section {
            Button("Logout", role: .destructive) {
                Task {
                    await handleLogout()
                }
            }
        }
    }

    private func handleLogout() async {
        try? await appUser?.logout()
        await favoriteManager.clearAll()
    }

    private func startObserving() {
        guard observationTask == nil, let appUser else { return }

        observationTask = Task {
            // İlk state'i al
            let initialInfo = await appUser.info
            let initialLoggedIn = await appUser.isLoggedIn

            await MainActor.run {
                withAnimation {
                    if initialLoggedIn, let info = initialInfo {
                        userState = .loggedIn(info)
                    } else {
                        userState = .notLoggedIn
                    }
                }
            }

            // Değişiklikleri izle
            for await change in appUser.stateChanges {
                guard !Task.isCancelled else { break }

                await MainActor.run {
                    withAnimation {
                        if change.isLoggedIn, let info = change.info {
                            userState = .loggedIn(info)
                        } else {
                            userState = .notLoggedIn
                        }
                    }
                }
            }
        }
    }
}
