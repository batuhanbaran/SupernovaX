//
//  UserRegistration
//  UserRegistration
//
//  Created by Batuhan BARAN on 1.07.2025.
//

import Foundation
import Factory
import UserKitLive

public struct UserRegistration {

    public static func register() {
        Container.shared.appUser.register {
            AppUserLive()
        }
    }
}
