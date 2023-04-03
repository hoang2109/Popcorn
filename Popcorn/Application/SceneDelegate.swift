//
//  SceneDelegate.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 2/4/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    lazy var networkService: DataTransferService = {
        let queryParameters = [
            "api_key": AppConfiguration.apiKey,
            "language": "en"]
        
        let configuration = DefaultNetworkConfiguration(
            baseURL: AppConfiguration.apiBaseURL,
            queryParameters: queryParameters)
        
        return URLSessionHTTPClient(with: configuration)
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let movieRepository = DefaultMovieRepository(networkService: networkService)
        
        let popularMoviesUseCase = DefaultFetchPopularMoviesUseCase(movieRepository: movieRepository)
        let topRatedMoviesUseCase = DefaultFetchTopRatedMoviesUseCase(movieRepository: movieRepository)
        let upcomingMoviesUseCase = DefaultFetchUpComingMoviesUseCase(movieRepository: movieRepository)
        let nowplayingMoviesUseCase = DefaultFetchLatestMoviesUseCase(movieRepository: movieRepository)
        let viewModel = DefaultHomeViewModel(fetchPopularMoviesUseCase: popularMoviesUseCase,
                                             fetchTopRatedMoviesUseCase: topRatedMoviesUseCase,
                                             fetchUpComingMoviesUseCase: upcomingMoviesUseCase,
                                             fetchLatestMoviesUseCase: nowplayingMoviesUseCase)
        
        window.rootViewController = HomeViewController(viewModel)
        
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}

