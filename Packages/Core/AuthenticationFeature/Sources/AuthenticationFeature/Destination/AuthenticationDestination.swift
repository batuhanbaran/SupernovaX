//
//  AuthenticationDestination.swift
//  AuthenticationFeature
//
//  Created by Batuhan Baran on 24.09.2025.
//

import AuthenticationKit
import NavigatorUI
import SwiftUI
import UIComponentKit

enum AuthenticationDestination: NavigationDestination {

    case signIn
    case signUp
    case resetPassword

    var method: NavigationMethod {
        switch self {
        case .signIn: return .sheet
        case .signUp, .resetPassword: return .push
        }
    }

    var title: String {
        switch self {
        case .signIn:
            return "Sign In"
        case .signUp:
            return "Sign Up"
        case .resetPassword:
            return "Reset Password"
        }
    }

    @ViewBuilder
    public var body: some View {
        switch self {
        case .signIn:
            AuthenticationDestinationView(selectedSegment: .signIn)
        case .signUp:
            AuthenticationDestinationView(selectedSegment: .signUp)
        case .resetPassword:
            ResetPasswordView()
        }
    }
}
