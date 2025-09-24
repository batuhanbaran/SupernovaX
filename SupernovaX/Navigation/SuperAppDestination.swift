//
//  SuperAppDestination.swift
//  SupernovaX
//
//  Created by Batuhan Baran on 21.09.2025.
//

import SwiftUI
import NavigatorUI
import TodoX

// MARK: - SuperApp Navigation Destinations
/// Navigation destinations for SuperApp level (between different mini-apps)
public enum SuperAppDestination: NavigationDestination {
    case superAppSheet
    case todoX
    
    public var body: some View {
        switch self {
        case .superAppSheet:
            SuperAppSheet()
        case .todoX:
            TodoXTabView()
        }
    }
    
    public var method: NavigationMethod {
        switch self {
        case .superAppSheet:
            .sheet
        case .todoX:
            .cover
        }
    }
}
