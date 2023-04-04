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
    
    var nav = UINavigationController()

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
        
        let homeVC = HomeViewController(viewModel)
        homeVC.onSelect = onSelect(_:)
        nav = UINavigationController(rootViewController: homeVC)
        window.rootViewController = nav
        
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    func onSelect(_ movieId: Int) {
        let creditsRepository = DefaultCreditRepository(networkService: networkService)
        let videosRepository = DefaultVideoTrailerRepository(networkService: networkService)
        let movieRepository = DefaultMovieRepository(networkService: networkService)
        
        let fetchCreditsUseCase = DefaultFetchCastsUseCase(creditRepository: creditsRepository)
        let fetchVideosUseCase = DefaultFetchVideoTrialersUseCase(videoTrailerRepository: videosRepository)
        let fetchMovieDetailUseCase = DefaultFetchMovieDetailUseCase(movieRepository: movieRepository)
        
        let viewModel = MovieDetailViewModel(movieId: movieId, fetchMovieDetailUseCase: fetchMovieDetailUseCase, fetchCreditsUseCase: fetchCreditsUseCase, fetchVideoTrailerUseCase: fetchVideosUseCase)
        let storyboard = UIStoryboard(name: String(describing: MovieDetailViewController.self), bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as! MovieDetailViewController
        vc.viewModel = viewModel
        nav.pushViewController(vc, animated: true)
    }
}

