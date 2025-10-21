// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TokenKit",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "TokenKit",
            targets: ["TokenKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/auth0/JWTDecode.swift", from: "3.3.0"),
        .package(url: "https://github.com/hmlongco/Factory.git", from: "2.5.3")
    ],
    targets: [
        .target(
            name: "TokenKit",
            dependencies: [
                .product(name: "JWTDecode", package: "JWTDecode.swift"),
                "Factory"
            ]
        )
    ]
)
