//
//  ResetPasswordView.swift
//  AuthenticationFeature
//
//  Created by Batuhan Baran on 25.09.2025.
//

import NavigatorUI
import SwiftUI

struct ResetPasswordView: View {
    @Environment(\.navigator) private var navigator

    public var body: some View {
        VStack(spacing: 20) {
            Text("Reset Password")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Enter your email to receive reset instructions")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            VStack(spacing: 16) {
                TextField("Email", text: .constant(""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Send Reset Link") {
                    // Handle password reset
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            
            Button("Back to Sign In") {
                navigator.pop() // Sadece bir önceki ekrana dön
            }
            .font(.footnote)
        }
        .padding()
        .navigationTitle("Reset Password")
        .navigationBarTitleDisplayMode(.inline)
    }
}
