//
//  SignUpView.swift
//  AuthenticationFeature
//
//  Created by Batuhan Baran on 25.09.2025.
//

import AuthenticationKit
import NavigatorUI
import SwiftUI

struct SignUpView: View {
    @Environment(\.navigator) private var navigator
    @Binding var selectedSegment: AuthenticationSegment

    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Join us today!")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            // Sign up form would go here
            VStack(spacing: 16) {
                TextField("Full Name", text: .constant(""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Email", text: .constant(""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Password", text: .constant(""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Confirm Password", text: .constant(""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Sign Up") {
                    // Handle sign up
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            
            Button("Already have an account? Sign In") {
                withAnimation {
                    selectedSegment = .signIn
                }
            }
            .font(.footnote)
        }
        .padding()
    }
}
