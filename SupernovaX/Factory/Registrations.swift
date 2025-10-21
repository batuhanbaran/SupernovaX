//
//  Registrations.swift
//  SupernovaX
//
//  Created by Batuhan BARAN on 2.06.2025.
//

import AuthenticationKitRegistration
import Factory
import Foundation
import NetworkRegistration
import TokenRegistration
import UserRegistration

extension Container: @retroactive AutoRegistering {

    public func autoRegister() {
        NetworkRegistrations.register()
        AuthenticationRegistration.register()
        UserRegistration.register()
        TokenRegistration.register()
    }
}
