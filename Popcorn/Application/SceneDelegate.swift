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
        
        let vc = createMovieListViewController()
        
        nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.barStyle = .black
        window.rootViewController = nav
        
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    
    
    func onSelect(_ movieId: Int) {
        let vc = createMovieDetailViewController(movieId)
        nav.pushViewController(vc, animated: true)
    }
    
    func createHomeViewController() -> HomeViewController {
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
        return homeVC
    }
    
    func createMovieDetailViewController(_ movieId: Int) -> MovieDetailViewController {
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
        return vc
    }
    
    func createSearchMovieViewController() -> SearchMovieViewController {
        let movieRepository = DefaultMovieRepository(networkService: networkService)
        let fetchDiscoveryMoviesUseCase = DefaultFetchDiscoverMoviesUseCase(movieRepository: movieRepository)
        let searchMoviesUseCase = DefaultSearchMoviesUseCase(movieRepository: movieRepository)
        let viewModel = SearchMovieViewModel(fetchDiscoveryMovieUseCase: fetchDiscoveryMoviesUseCase, searchMoviesUseCase: searchMoviesUseCase)
        let vc = SearchMovieViewController.create(with: viewModel)
        vc.onSelect = onSelect(_:)
        return vc
    }
    
    func createMovieListViewController() -> MovieListViewController {
        let movieRepository = DefaultMovieRepository(networkService: networkService)
        let fetchMoviesByCategoryUseCase = DefaultFetchMoviesByCategoryUseCase(movieRepository: movieRepository)
        let viewModel = MovieListViewModel(category: "popular", fetchMoviesUseCase: fetchMoviesByCategoryUseCase)
        let vc = MovieListViewController.create(with: viewModel)
        vc.onSelect = onSelect(_:)
        return vc
    }
}

