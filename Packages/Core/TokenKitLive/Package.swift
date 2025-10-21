// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TokenKitLive",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "TokenKitLive",
            targets: ["TokenKitLive"]),
    ],
    dependencies: [
        .package(path: "../TokenKit"),
        .package(url: "https://github.com/auth0/JWTDecode.swift", from: "3.3.0"),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess", from: "4.2.2")
    ],
    targets: [
        .target(
            name: "TokenKitLive",
            dependencies: [
                "TokenKit",
                .product(name: "JWTDecode", package: "JWTDecode.swift"),
                .product(name: "KeychainAccess", package: "KeychainAccess")
            ]
        ),
    ]
)
