//
//  PlaceholderImageView.swift
//  ProductListUI
//
//  Created by Batuhan Baran on 11.09.2025.
//

import SwiftUI

// MARK: - Placeholder Image View
public struct PlaceholderImageView: View {
    public init() {}

    public var body: some View {
        ZStack {
            Color.gray.opacity(0.1)
            Image(systemName: "photo")
                .font(.system(size: 40))
                .foregroundColor(.gray.opacity(0.5))
        }
    }
}
