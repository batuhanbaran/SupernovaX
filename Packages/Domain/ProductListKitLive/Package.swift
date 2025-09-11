// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProductListKitLive",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ProductListKitLive",
            targets: ["ProductListKitLive"]),
    ],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Factory.git", from: "2.5.3"),
        // Local dependency to FavoriteKit
        .package(path: "../NetworkKit"),
        .package(path: "../UIComponentKit")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ProductListKitLive",
            dependencies: ["Factory", "NetworkKit", "UIComponentKit"]
        )
    ]
)
