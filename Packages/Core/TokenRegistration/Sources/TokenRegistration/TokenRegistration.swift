//
//  TokenRegistration
//  TokenRegistration
//
//  Created by Batuhan BARAN on 1.07.2025.
//

import Foundation
import Factory
import TokenKitLive

public struct TokenRegistration {

    public static func register() {
        Container.shared.tokenManager.register {
            TokenManagerLive()
        }
    }
}
