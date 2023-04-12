//
//  DefaultSearchMovieComponentsFactory.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 12/4/23.
//

import Foundation
import UIKit

class DefaultSearchMovieComponentsFactory: SearchMovieComponentsFactory {
    private let networkService: DataTransferService
    
    private lazy var movieRepository: MovieRepository = {
        return DefaultMovieRepository(networkService: networkService)
    }()
    
    init(networkService: DataTransferService) {
        self.networkService = networkService
    }
    
    func createSearchMovieViewController(coordinator: SearchMovieCoordinator) -> UIViewController {
        let viewModel = SearchMovieViewModel(fetchDiscoveryMovieUseCase: makeFetchDiscoverMoviesUseCase(),
                                             searchMoviesUseCase: makeSearchMoviesUseCase(),
                                             coordinator: coordinator)
        let vc = SearchMovieViewController.create(with: viewModel)
        return vc
    }
    
    private func makeFetchDiscoverMoviesUseCase() -> FetchDiscoverMoviesUseCase {
        DefaultFetchDiscoverMoviesUseCase(movieRepository: movieRepository)
    }
    
    private func makeSearchMoviesUseCase() -> SearchMoviesUseCase {
        DefaultSearchMoviesUseCase(movieRepository: movieRepository)
    }
}
