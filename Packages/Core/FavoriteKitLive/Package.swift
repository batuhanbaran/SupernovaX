// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

import PackageDescription

let package = Package(
    name: "FavoriteKitLive",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .watchOS(.v10),
        .tvOS(.v17),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "FavoriteKitLive",
            targets: ["FavoriteKitLive"]
        ),
    ],
    dependencies: [
        .package(path: "../FavoriteKit")
    ],
    targets: [
        .target(
            name: "FavoriteKitLive",
            dependencies: [
                "FavoriteKit"
            ]
        )
    ]
)
