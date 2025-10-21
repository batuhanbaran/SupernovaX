//
//  AuthenticationDestinationView.swift
//  AuthenticationFeature
//
//  Created by Batuhan Baran on 10.10.2025.
//

import AuthenticationKit
import NavigatorUI
import SwiftUI
import UIComponentKit

public struct AuthenticationDestinationView: View {

    @State var selectedSegment: AuthenticationSegment
    @Environment(\.navigator) private var navigator

    public init(selectedSegment: AuthenticationSegment = .signIn) {
        self.selectedSegment = selectedSegment
    }

    public var body: some View {
        VStack {
            SegmentControlView(
                items: AuthenticationSegment.allCases,
                selectedSegment: $selectedSegment,
                distribution: .fillEqually
            )
            .padding(20)

            switch selectedSegment {
            case .signIn:
                SignInView(selectedSegment: $selectedSegment)
            case .signUp:
                SignUpView(selectedSegment: $selectedSegment)
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}

public enum AuthenticationSegment: Segmentable {
    case signIn
    case signUp

    nonisolated public var description: String {
        switch self {
        case .signIn:
            return "Sign In"
        case .signUp:
            return "Sign Up"
        }
    }

    nonisolated public var underlineColor: Color {
        return .blue
    }
}
