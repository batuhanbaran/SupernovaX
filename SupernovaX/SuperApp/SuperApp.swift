//
//  SuperApp.swift
//  SupernovaX
//
//  Created by Batuhan Baran on 21.09.2025.
//

import SwiftUI

// MARK: - Super App Model
struct SuperApp: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
    let description: String
}
