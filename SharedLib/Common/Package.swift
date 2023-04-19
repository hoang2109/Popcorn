// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Common",
    platforms: [
            .iOS(.v13)
        ],
    products: [
        .library(
            name: "Common",
            targets: ["Common"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/AlamofireImage.git", .upToNextMajor(from: "4.0.0"))
    ],
    targets: [
        .target(
            name: "Common",
            dependencies: ["AlamofireImage"]),
    ]
)
