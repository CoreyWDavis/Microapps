// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DesignKit",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "DesignKit",
            targets: ["DesignKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DesignKit",
            dependencies: [],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
