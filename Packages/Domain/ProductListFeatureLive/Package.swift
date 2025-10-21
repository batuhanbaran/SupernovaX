// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProductListFeatureLive",
    platforms: [
        .iOS(.v17), // Optional: Match platform if needed
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ProductListFeatureLive",
            targets: ["ProductListFeatureLive"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Navigator.git", from: "1.3.1"),
        .package(url: "https://github.com/hmlongco/Factory.git", from: "2.5.3"),
        .package(path: "../ProductListKit"),
        .package(path: "../ProductListKitLive"),
        .package(path: "../FavoriteKitLive"),
        .package(path: "../../Core/AppDestinationKit"),
        .package(path: "../../Core/UIComponentKit"),
        .package(path: "../ProductListUI"),
        .package(path: "../UserKit"),
        .package(path: "../UserKitLive")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ProductListFeatureLive",
            dependencies: [
                .product(name: "NavigatorUI", package: "Navigator"),
                "ProductListKit",
                "ProductListKitLive",
                "FavoriteKitLive",
                "AppDestinationKit",
                "UIComponentKit",
                "ProductListUI",
                "Factory",
                "UserKit",
                "UserKitLive"
            ]
        ),
    ]
)
