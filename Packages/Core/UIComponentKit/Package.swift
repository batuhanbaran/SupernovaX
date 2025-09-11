// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIComponentKit",
    platforms: [.iOS(.v17), .macOS(.v13)],
    products: [
        .library(
            name: "UIComponentKit",
            targets: ["UIComponentKit"]),
    ],
    dependencies: [
        // Factory remote dependency
        .package(url: "https://github.com/hmlongco/Factory.git", from: "2.3.0"),

        // Local packages
        .package(path: "../NetworkKit"),
        .package(path: "../Models"),
        .package(path: "../ExtensionsKit"),
    ],
    targets: [
        .target(
            name: "UIComponentKit",
            dependencies: [
                .product(name: "Factory", package: "Factory"),
                "NetworkKit",
                "Models",
                "ExtensionsKit"
            ]),
    ]
)
