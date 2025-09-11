//
//  ProductImageView.swift
//  ProductListUI
//
//  Created by Batuhan Baran on 11.09.2025.
//

import SwiftUI

// MARK: - Product Image View
public struct ProductImageView: View {
    public let imageURL: String?
    @Binding public var imageLoadFailed: Bool

    public init(imageURL: String?, imageLoadFailed: Binding<Bool>) {
        self.imageURL = imageURL
        self._imageLoadFailed = imageLoadFailed
    }

    public var body: some View {
        GeometryReader { geometry in
            if let imageURL = imageURL, !imageLoadFailed {
                AsyncImage(url: URL(string: imageURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: geometry.size.width, height: geometry.size.width)
                            .background(Color.gray.opacity(0.1))
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.width)
                            .clipped()
                    case .failure:
                        PlaceholderImageView()
                            .frame(width: geometry.size.width, height: geometry.size.width)
                            .onAppear { imageLoadFailed = true }
                    @unknown default:
                        PlaceholderImageView()
                            .frame(width: geometry.size.width, height: geometry.size.width)
                    }
                }
            } else {
                PlaceholderImageView()
                    .frame(width: geometry.size.width, height: geometry.size.width)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
