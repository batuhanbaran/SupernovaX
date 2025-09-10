//
//  Optional+Extensions.swift
//  UserListFeature
//
//  Created by Batuhan BARAN on 17.06.2025.
//

import Foundation

public extension Optional where Wrapped == String {
    var orUnknown: String {
        self ?? "Bilinmiyor"
    }
}
