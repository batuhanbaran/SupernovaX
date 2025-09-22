//
//  Registrations.swift
//  SupernovaX
//
//  Created by Batuhan BARAN on 2.06.2025.
//

import Factory
import Foundation
import NetworkRegistration

extension Container: @retroactive AutoRegistering {

    public func autoRegister() {
        NetworkRegistrations.register()
    }
}
