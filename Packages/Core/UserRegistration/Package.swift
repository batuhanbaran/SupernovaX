// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UserRegistration",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UserRegistration",
            targets: ["UserRegistration"]),
    ],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Factory.git", from: "2.5.3"),
        .package(path: "../UserKitLive")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "UserRegistration", dependencies: ["UserKitLive", "Factory"]),
    ]
)
