// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Chain",
    platforms: [
       .macOS(.v10_15),
       .watchOS("6.0")
    ],
    products: [
        .library(name: "Chain", targets: ["Chain"]),
    ],
    dependencies: [
        // External
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1"),
    ],
    targets: [
        .target(
            name: "Chain",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        ),
        .target(
            name: "ChainDemo",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .target(name: "Chain")
            ]
        ),
        // .testTarget(
        //     name: "ChainTests",
        //     dependencies: [
        //         .target(name: "Chain")
        //     ]
        // )
    ]
)
