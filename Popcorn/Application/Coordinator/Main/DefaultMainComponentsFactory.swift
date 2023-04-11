//
//  DefaultMainComponentsFactory.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 10/4/23.
//

import Foundation
import UIKit

class DefaultMainComponentsFactory: MainComponentsFactory {
    
    private let networkService: DataTransferService
    
    private lazy var movieRepository: MovieRepository = {
        return DefaultMovieRepository(networkService: networkService)
    }()
    private lazy var creditRepository: CreditRepository = {
        return DefaultCreditRepository(networkService: networkService)
    }()
    
    init(networkService: DataTransferService) {
        self.networkService = networkService
    }
    
    func createHomeViewController(coordinator: MainCoordinator) -> UIViewController {
        let viewModel = DefaultHomeViewModel(fetchPopularMoviesUseCase: makeFetchPopularMoviesUseCase(),
                                             fetchTopRatedMoviesUseCase: makeFetchTopRatedMoviesUseCase(),
                                             fetchUpComingMoviesUseCase: makeFetchUpComingMoviesUseCase(),
                                             fetchLatestMoviesUseCase: makeFetchLatestMoviesUseCase(),
                                             coordinator: coordinator)
        
        let homeVC = HomeViewController(viewModel)
        return homeVC
    }
    
    func createMovieListViewController(with cateId: String, coordinator: MainCoordinator) -> UIViewController {
        let viewModel = MovieListViewModel(category: cateId,
                                           fetchMoviesUseCase: makeFetchMoviesByCategoryUseCase(),
                                           coordinator: coordinator)
        let vc = MovieListViewController.create(with: viewModel)
        return vc
    }
    
    func createMovieDetailCoordinator(navigationController: UINavigationController, completion: @escaping () -> Void) -> MovieDetailCoordinator {
        let factory = DefaultMovieDetailComponentFactory(networkService: networkService)
        let coordinator = DefaultMovieDetailCoordinator(navigationController: navigationController, componentFactory: factory)
        coordinator.onFinish = completion
        return coordinator
    }
    
    private func makeFetchPopularMoviesUseCase() -> FetchPopularMoviesUseCase {
        DefaultFetchPopularMoviesUseCase(movieRepository: movieRepository)
    }
    
    private func makeFetchTopRatedMoviesUseCase() -> FetchTopRatedMoviesUseCase {
        DefaultFetchTopRatedMoviesUseCase(movieRepository: movieRepository)
    }
    
    private func makeFetchUpComingMoviesUseCase() -> FetchUpComingMoviesUseCase {
        DefaultFetchUpComingMoviesUseCase(movieRepository: movieRepository)
    }
    
    private func makeFetchLatestMoviesUseCase() -> FetchLatestMoviesUseCase {
        DefaultFetchLatestMoviesUseCase(movieRepository: movieRepository)
    }
    
    private func makeFetchMoviesByCategoryUseCase() -> FetchMoviesByCategoryUseCase {
        DefaultFetchMoviesByCategoryUseCase(movieRepository: movieRepository)
    }
}
