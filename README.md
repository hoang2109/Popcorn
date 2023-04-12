[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Platforms](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
[![Swift Version](https://img.shields.io/badge/Swift-5-F16D39.svg?style=flat)](https://developer.apple.com/swift)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

A movie app shows the most popular, top rated movies also can view detail and search for movie. The source come from [TMDb API](https://www.themoviedb.org/). The app is written in Swift & UIKit. The app demostrates how to apply some popular design patterns to make code clean, easier to test, maintain and add new functionalities, follow SOLID principles.

## In Progress:
Currently, the app is monolithic app. The problem is when app grows, there will be longer build time, hard to reuse code or separate work across different teams. So I'm working on separate it to different feature modules by using Interface Modules. Each feature module will have its own demo target and entry point. All of them will be composed to the main application.

### TODO:
* Modularize an app
* Add tests
* Add cache data to view offline

## Built with
- Swift 5
- RxSwift
- Clean Architecture
- MVVM Pattern
- Coordinator Pattern
- Dependency Injection
- Swift Package Manager

## Requirements
1. Xcode 14.0+

## Getting started
1. Clone this repository
2. Open Popcorn/Popcorn.xcodeproj and run
