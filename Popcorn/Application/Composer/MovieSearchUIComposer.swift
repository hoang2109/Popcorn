//
//  MovieSearchUIComposer.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 9/4/23.
//

import Foundation

enum MovieSearchUIComposer {
    static func compose(_ networkService: DataTransferService, _ delegate: SearchMovieViewControllerDelegate?) -> SearchMovieViewController {
        let movieRepository = DefaultMovieRepository(networkService: networkService)
        let fetchDiscoveryMoviesUseCase = DefaultFetchDiscoverMoviesUseCase(movieRepository: movieRepository)
        let searchMoviesUseCase = DefaultSearchMoviesUseCase(movieRepository: movieRepository)
        let viewModel = SearchMovieViewModel(fetchDiscoveryMovieUseCase: fetchDiscoveryMoviesUseCase, searchMoviesUseCase: searchMoviesUseCase)
        let vc = SearchMovieViewController.create(with: viewModel, delegate)
        return vc
    }
}
