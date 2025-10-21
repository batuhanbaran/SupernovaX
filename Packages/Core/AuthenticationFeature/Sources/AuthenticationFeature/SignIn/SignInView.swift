//
//  SignInView.swift
//  AuthenticationFeature
//
//  Created by Batuhan Baran on 25.09.2025.
//

import AuthenticationKit
import Factory
import NavigatorUI
import SwiftUI

struct SignInView: View {
    @Injected(\.authenticationService) private var service
    @Environment(\.navigator) private var navigator
    @Binding var selectedSegment: AuthenticationSegment

    init(selectedSegment: Binding<AuthenticationSegment>) {
        self._selectedSegment = selectedSegment
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome Back!")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Sign in to your account")
                .font(.subheadline)
                .foregroundColor(.secondary)

            // Login form would go here
            VStack(spacing: 16) {
                TextField("Email", text: .constant(""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                SecureField("Password", text: .constant(""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Sign In") {
                    Task {
                        let _ = try await service?.signIn(with: .init(username: "emilys", password: "emilyspass"))
                        navigator.dismiss()
                    }
                }
            }

            HStack {
                Button("Sign Up") {
                    withAnimation {
                        selectedSegment = .signUp
                    }
                }

                Spacer()

                Button("Forgot Password?") {
                    navigator.navigate(to: AuthenticationDestination.resetPassword)
                }
            }
        }
        .padding()
    }
}
