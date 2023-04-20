[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Platforms](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
[![Swift Version](https://img.shields.io/badge/Swift-5-F16D39.svg?style=flat)](https://developer.apple.com/swift)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

A movie app shows the most popular, top rated movies also can view detail and search for movie. The source come from [TMDb API](https://www.themoviedb.org/). The app is written in Swift & UIKit. The app demostrates how to apply some popular design patterns to make code clean, easier to test, maintain and add new functionalities, follow SOLID principles.

First the project is monolithic then I divided it into 5 packages using SPM to exercise Modular Architecture using Interface Modules techinique. Each package has interface module and implementation detail module. If a module need to depend on another module, it will depend on interface module. It is how I make modularization more effective by decoupling implementation modules. Each feature module will have its own demo target and entry point to run demo app. All of them are composed to the main application.

### TODO:
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
2. Open Popcorn/Popcorn.xcworkspace and run

## Screenshots

<img width="24%" src="https://user-images.githubusercontent.com/1131493/231416539-ea2087a2-5f51-411c-9e9d-84541e8590f5.png"> <img width="24%" src="https://user-images.githubusercontent.com/1131493/231416596-b5d6385c-c299-4e19-8917-45a39029f4d9.png"> <img width="24%" src="https://user-images.githubusercontent.com/1131493/231416608-625008c1-c5e9-4ba3-b5b1-d921e05ed250.png"> <img width="24%" src="https://user-images.githubusercontent.com/1131493/231416616-c399f695-0ab8-413d-85dc-874f2e138157.png">
<img width="24%" src="https://user-images.githubusercontent.com/1131493/231416687-51ad9904-5bdc-41e0-b3c7-46bd9e466507.png"> <img width="24%" src="https://user-images.githubusercontent.com/1131493/231416742-ed005fbb-57c8-4e75-9c8c-b1dace31bc2e.png"> <img width="24%" src="https://user-images.githubusercontent.com/1131493/231416769-9f4903fd-4e86-4823-ba3d-cde7699e1a96.png">
