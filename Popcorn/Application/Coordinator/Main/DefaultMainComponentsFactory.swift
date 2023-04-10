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
    private lazy var videoTrailerRepository: VideoTrailerRepository = {
        return DefaultVideoTrailerRepository(networkService: networkService)
    }()
    private lazy var actorRepository: ActorRepository = {
        return DefaultActorRepository(networkService: networkService)
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
    
    func createMovieDetailViewController(with movieId: Int, coordinator: MainCoordinator) -> UIViewController {
        let viewModel = MovieDetailViewModel(movieId: movieId,
                                             fetchMovieDetailUseCase: makeFetchMovieDetailUseCase(),
                                             fetchCreditsUseCase: makeFetchCastsUseCase(),
                                             fetchVideoTrailerUseCase: makeFetchVideoTrialersUseCase(),
                                             coordinator: coordinator)
        let vc = MovieDetailViewController.create(with: viewModel)
        return vc
    }
    
    func createActorDetailViewController(with actorId: Int, coordinator: MainCoordinator) -> UIViewController {
        let viewModel = ActorDetailViewModel(actorId: actorId,
                                             fetchActorDetailUseCase: makeFetchActorDetailUseCase(),
                                             fetchActorCreditsUseCase: makeFetchActorCreditsUseCase(),
                                             coordinator: coordinator)
        let vc = ActorDetailViewController.create(with: viewModel)
        return vc
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
    
    private func makeFetchCastsUseCase() -> DefaultFetchCastsUseCase {
        DefaultFetchCastsUseCase(creditRepository: creditRepository)
    }
    
    private func makeFetchVideoTrialersUseCase() -> FetchVideoTrialersUseCase {
        DefaultFetchVideoTrialersUseCase(videoTrailerRepository: videoTrailerRepository)
    }
    
    private func makeFetchMovieDetailUseCase() -> FetchMovieDetailUseCase {
        DefaultFetchMovieDetailUseCase(movieRepository: movieRepository)
    }
    
    private func makeFetchActorDetailUseCase() -> FetchActorDetailUseCase {
        DefaultFetchActorDetailUseCase(actorRepository: actorRepository)
    }
    
    private func makeFetchActorCreditsUseCase() -> FetchActorCreditsUseCase {
        DefaultFetchActorCreditsUseCase(actorRepository: actorRepository)
    }
}
