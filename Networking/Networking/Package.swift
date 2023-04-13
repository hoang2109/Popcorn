// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Networking",
    products: [
        .library(name: "Networking", targets: ["Networking"]),
        .library(name: "NetworkingInterface", targets: ["NetworkingInterface"]),
    ],
    dependencies: [
      .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0"))
    ],
    targets: [
        .target(name: "Networking", dependencies: ["NetworkingInterface", "RxSwift"]),
        .target(name: "NetworkingInterface", dependencies: ["RxSwift"])
    ]
)
