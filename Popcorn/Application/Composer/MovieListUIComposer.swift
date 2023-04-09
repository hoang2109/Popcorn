//
//  MovieListUIComposer.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 9/4/23.
//

import Foundation

enum MovieListUIComposer {
    static func compose(_ networkService: DataTransferService, _ delegate: MovieListViewControllerDelegate?) -> MovieListViewController {
        let movieRepository = DefaultMovieRepository(networkService: networkService)
        let fetchMoviesByCategoryUseCase = DefaultFetchMoviesByCategoryUseCase(movieRepository: movieRepository)
        let viewModel = MovieListViewModel(category: "popular", fetchMoviesUseCase: fetchMoviesByCategoryUseCase)
        let vc = MovieListViewController.create(with: viewModel, delegate)
        return vc
    }
}
