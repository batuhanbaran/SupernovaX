// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CartKitLive",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CartKitLive",
            targets: ["CartKitLive"]),
    ],
    dependencies: [
        .package(path: "../CartKit"),
        .package(path: "../NetworkKit"),
        .package(url: "https://github.com/hmlongco/Factory.git", from: "2.5.3")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CartKitLive",
            dependencies: ["CartKit", "Factory", "NetworkKit"]
        )
    ]
)
