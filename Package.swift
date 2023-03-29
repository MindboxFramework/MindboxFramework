// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MindboxFramework",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "MindboxFramework",
            targets: ["MindboxFramework"]),
    ],
    dependencies: [
        .package(url: "https://github.com/mindbox-cloud/ios-sdk", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "MindboxFramework",
            dependencies: [
                .product(name: "Mindbox", package: "ios-sdk"),
            ]),
    ]
)
