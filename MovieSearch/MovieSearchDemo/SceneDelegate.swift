//
//  SceneDelegate.swift
//  MovieSearchDemo
//
//  Created by Hoang Nguyen on 20/4/23.
//

import UIKit
import MovieDetailInterface
import NetworkingInterface
import Networking
import MovieSearchInterface
import MovieSearchFeature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    lazy var networkService: DataTransferService = {
        let queryParameters = [
            "api_key": "680ebd51dcc601e95626cfd2b274da81",
            "language": "en"]
        
        let configuration = DefaultNetworkConfiguration(
            baseURL: "https://api.themoviedb.org/3",
            queryParameters: queryParameters)
        
        return URLSessionHTTPClient(with: configuration)
    }()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let nav = UINavigationController()
        nav.navigationBar.barStyle = .black
        
        let movieSearchComponentFactory = DefaultSearchMovieComponentsFactory(networkService: networkService)
        let searchModuleFactory = DefaultSearchModuleFactory(searchMovieComponentsFactory: movieSearchComponentFactory, movieDetailModuleFactory: MockMovieDetailModuleFactory())
        
        let coordinator = searchModuleFactory.createSearchMovieCoordinator(navigationController: nav)
        coordinator.start()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}

class MockMovieDetailModuleFactory: MovieDetailModuleFactory {
    func createMovieDetailCoordinator(movieId: Int?, navigationController: UINavigationController, completion: @escaping () -> Void) -> MovieDetailCoordinator {
        return MockMovieDetailCoordinator(movieId: movieId, navigationController: navigationController)
    }
}

class MockMovieDetailCoordinator: MovieDetailCoordinator {
    
    var movieId: Int?
    var navigationController: UINavigationController
    
    init(movieId: Int?, navigationController: UINavigationController) {
        self.movieId = movieId
        self.navigationController = navigationController
    }
    
    var onFinish: (() -> Void)?
    
    func start() {
        print("Go To Movie Detail \(movieId ?? -1)")
    }
    
    func navigate(to step: MovieDetailStep) {
        
    }
}

