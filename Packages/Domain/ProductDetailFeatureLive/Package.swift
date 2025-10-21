// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProductDetailFeatureLive",
    platforms: [
        .iOS(.v17), // Optional: Match platform if needed
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ProductDetailFeatureLive",
            targets: ["ProductDetailFeatureLive"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Navigator.git", from: "1.3.1"),
        .package(path: "../ProductDetailKit"), // Adjust path as appropriate
        .package(path: "../AppDestinationKit") // Adjust path as appropriate
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ProductDetailFeatureLive",
            dependencies: [
                .product(name: "NavigatorUI", package: "Navigator"),
                "ProductDetailKit",
                "AppDestinationKit"
            ]
        ),
    ]
)
