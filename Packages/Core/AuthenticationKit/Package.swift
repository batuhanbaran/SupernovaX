// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AuthenticationKit",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AuthenticationKit",
            targets: ["AuthenticationKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Navigator.git", from: "1.3.1"),
        .package(url: "https://github.com/hmlongco/Factory.git", from: "2.5.3"),
        .package(path: "../Models"),
        .package(path: "../NetworkKit"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AuthenticationKit",
            dependencies: [
                .product(name: "NavigatorUI", package: "Navigator"),
                "Models",
                "Factory",
                "NetworkKit"
            ])
    ]
)
