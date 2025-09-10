// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FavoriteKit",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .watchOS(.v10),
        .tvOS(.v17),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "FavoriteKit",
            targets: ["FavoriteKit"]
        ),
    ],
    dependencies: [
        // No external dependencies - pure protocol/interface layer
    ],
    targets: [
        .target(
            name: "FavoriteKit",
            dependencies: []
        )
    ]
)
