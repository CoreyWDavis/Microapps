// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PlanetKit",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PlanetKit",
            targets: ["PlanetKit"]),
    ],
    dependencies: [
        .package(path: "../CoreKit"),
        .package(path: "../DesignKit"),
        .package(path: "../PlatformKit")
    ],
    targets: [
        .target(
            name: "PlanetKit",
            dependencies: ["CoreKit", "DesignKit", "PlatformKit"])
    ]
)
