// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MovieSearchFeature",
    defaultLocalization: "en",
    platforms: [
                .iOS(.v13)
            ],
    products: [
        .library(
            name: "MovieSearchFeature",
            targets: ["MovieSearchFeature"]),
        .library(
            name: "MovieSearchInterface",
            targets: ["MovieSearchInterface"]),
    ],
    dependencies: [
        .package(path: "../../Networking/Networking"),
        .package(path: "../../SharedLib/Common"),
        .package(path: "../../MovieDetail/MovieDetailFeature"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
        .package(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", .upToNextMajor(from: "5.0.0")),
    ],
    targets: [
        .target(
            name: "MovieSearchInterface",
            dependencies: ["Common"]),
        .target(
            name: "MovieSearchFeature",
            dependencies: ["Networking", "RxSwift", "RxDataSources", "MovieDetailFeature", "Common", "MovieSearchInterface"]),
    ]
)
