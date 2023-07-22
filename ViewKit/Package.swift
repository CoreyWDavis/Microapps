// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ViewKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "ViewKit",
            targets: ["ViewKit"]),
    ],
    dependencies: [
        .package(path: "../DesignKit")
    ],
    targets: [
        .target(
            name: "ViewKit",
            dependencies: ["DesignKit"])
    ]
)
