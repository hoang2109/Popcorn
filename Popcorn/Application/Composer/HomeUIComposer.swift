//
//  HomeComposer.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 9/4/23.
//

import Foundation

enum HomeUIComposer {
    static func compose(_ networkService: DataTransferService, _ delegate: HomeViewControllerDelegate?) -> HomeViewController {
        let movieRepository = DefaultMovieRepository(networkService: networkService)
        
        let popularMoviesUseCase = DefaultFetchPopularMoviesUseCase(movieRepository: movieRepository)
        let topRatedMoviesUseCase = DefaultFetchTopRatedMoviesUseCase(movieRepository: movieRepository)
        let upcomingMoviesUseCase = DefaultFetchUpComingMoviesUseCase(movieRepository: movieRepository)
        let nowplayingMoviesUseCase = DefaultFetchLatestMoviesUseCase(movieRepository: movieRepository)
        let viewModel = DefaultHomeViewModel(fetchPopularMoviesUseCase: popularMoviesUseCase,
                                             fetchTopRatedMoviesUseCase: topRatedMoviesUseCase,
                                             fetchUpComingMoviesUseCase: upcomingMoviesUseCase,
                                             fetchLatestMoviesUseCase: nowplayingMoviesUseCase)
        
        let homeVC = HomeViewController(viewModel, delegate)
        return homeVC
    }
}
