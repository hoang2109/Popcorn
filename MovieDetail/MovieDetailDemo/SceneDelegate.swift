//
//  SceneDelegate.swift
//  MovieDetailDemo
//
//  Created by Hoang Nguyen on 19/4/23.
//

import UIKit
import MovieDetailFeature
import NetworkingInterface
import Networking

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
        
        let movieDetailComponentFactory = DefaultMovieDetailComponentFactory(networkService: networkService)
        let factory = DefaultMovieDetailModuleFactory(movieDetailComponentFactory: movieDetailComponentFactory)
        
        let coordinator = factory.createMovieDetailCoordinator(movieId: 502356, navigationController: nav) {}
        coordinator.start()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }

}

