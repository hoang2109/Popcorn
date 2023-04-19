// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MovieDetailFeature",
    defaultLocalization: "en",
    platforms: [
            .iOS(.v13)
        ],
    products: [
        .library(
            name: "MovieDetailFeature",
            targets: ["MovieDetailFeature"]),
        .library(
            name: "MovieDetailInterface",
            targets: ["MovieDetailInterface"]),
    ],
    dependencies: [
        .package(path: "../../Networking/Networking"),
        .package(path: "../../SharedLib/Common"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
        .package(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", .upToNextMajor(from: "5.0.0")),
    ],
    targets: [
        .target(
            name: "MovieDetailInterface",
            dependencies: ["Common"]),
        .target(
            name: "MovieDetailFeature",
            dependencies: ["Networking", "RxSwift", "RxDataSources", "MovieDetailInterface", "Common"]),
    ]
)
