//
//  MovieDetailUIComposer.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 9/4/23.
//

import Foundation

enum MovieDetailUIComposer {
    static func compose(_ movieId: Int, _ networkService: DataTransferService, _ delegate: MovieDetailViewControllerDelegate?) -> MovieDetailViewController {
        let creditsRepository = DefaultCreditRepository(networkService: networkService)
        let videosRepository = DefaultVideoTrailerRepository(networkService: networkService)
        let movieRepository = DefaultMovieRepository(networkService: networkService)
        
        let fetchCreditsUseCase = DefaultFetchCastsUseCase(creditRepository: creditsRepository)
        let fetchVideosUseCase = DefaultFetchVideoTrialersUseCase(videoTrailerRepository: videosRepository)
        let fetchMovieDetailUseCase = DefaultFetchMovieDetailUseCase(movieRepository: movieRepository)
        
        let viewModel = MovieDetailViewModel(movieId: movieId, fetchMovieDetailUseCase: fetchMovieDetailUseCase, fetchCreditsUseCase: fetchCreditsUseCase, fetchVideoTrailerUseCase: fetchVideosUseCase)
        let vc = MovieDetailViewController.create(with: viewModel, delegate)
        return vc
    }
}
