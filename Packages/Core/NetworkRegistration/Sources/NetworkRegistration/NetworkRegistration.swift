//
//  NetworkRegistration
//  NetworkRegistration
//
//  Created by Batuhan BARAN on 1.07.2025.
//

import Foundation
import Factory
import NetworkKit

public struct NetworkRegistrations {

    public static func register() {
        Container.shared.environmentManager.register {
            EnvironmentManager()
        }

        Container.shared.networkConfiguration.register {
            Container.shared.environmentManager().getCurrentConfiguration()
        }

        Container.shared.authInterceptor.register {
            AuthenticationInterceptor(tokenProvider: {
                return "your_access_token"
            })
        }

        Container.shared.loggingInterceptor.register {
            LoggingInterceptor()
        }

        Container.shared.networkService.register {
            NetworkService(
                configuration: Container.shared.networkConfiguration(),
                urlSession: .shared,
                requestInterceptors: [
                    Container.shared.authInterceptor(),
                    Container.shared.loggingInterceptor()
                ],
                responseInterceptors: [
                    Container.shared.loggingInterceptor()
                ]
            )
        }
    }
}

