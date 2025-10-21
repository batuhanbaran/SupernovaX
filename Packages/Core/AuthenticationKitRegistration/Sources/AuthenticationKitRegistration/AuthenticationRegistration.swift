//
//  AuthenticationRegistration.swift
//  AuthenticationKitRegistration
//
//  Created by Batuhan Baran on 25.09.2025.
//

import AuthenticationKit
import AuthenticationFeature
import Foundation
import Factory
import NetworkKit
import NavigatorUI

public struct AuthenticationRegistration {

    public static func register() {
        Container.shared.authenticationService.register {
            AuthenticationServiceLive()
        }
    }
}
