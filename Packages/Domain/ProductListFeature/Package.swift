// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProductListFeature",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ProductListFeature",
            targets: ["ProductListFeature"]),
    ],
    dependencies: [
        .package(path: "../Models"),
        .package(path: "../ProductListUI"),
        .package(path: "../ProductListKitLive")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ProductListFeature",
            dependencies: ["Models", "ProductListUI", "ProductListKitLive"]
        )
    ]
)
