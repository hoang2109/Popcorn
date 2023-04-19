// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MovieSearchFeature",
    products: [
        .library(name: "MovieSearchFeature", targets: ["MovieSearchFeature"]),
        .library(name: "MovieSearchInterface", targets: ["MovieSearchInterface"]),
    ],
    dependencies: [
      .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0"))
      .package(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", .upToNextMajor(from: "5.0.0"))
      .package(url: "https://github.com/Alamofire/AlamofireImage.git", .upToNextMajor(from: "4.0.0"))
    ],
    targets: [
        .target(name: "MovieSearchFeature", dependencies: ["NetworkingInterface", "RxSwift", "RxDataSources", "AlamofireImage"]),
        .target(name: "MovieSearchInterface", dependencies: ["RxSwift"])
    ]
)
