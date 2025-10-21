// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProductListUI",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ProductListUI",
            targets: ["ProductListUI"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(path: "../ProductListKit"),
        .package(path: "../FavoriteKitLive"),
        .package(path: "../../Core/UIComponentKit"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ProductListUI",
            dependencies: [
                "ProductListKit",
                "FavoriteKitLive",
                "UIComponentKit"
            ]
        ),

    ]
)

