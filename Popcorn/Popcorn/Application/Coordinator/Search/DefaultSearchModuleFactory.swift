//
//  DefaultSearchModuleFactory.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 12/4/23.
//

import Foundation
import UIKit
import MovieDetailInterface

class DefaultSearchModuleFactory: SearchModuleFactory {
    private let searchMovieComponentsFactory: SearchMovieComponentsFactory
    private let movieDetailModuleFactory: MovieDetailInterface.MovieDetailModuleFactory
    
    init(searchMovieComponentsFactory: SearchMovieComponentsFactory, movieDetailModuleFactory: MovieDetailInterface.MovieDetailModuleFactory) {
        self.searchMovieComponentsFactory = searchMovieComponentsFactory
        self.movieDetailModuleFactory = movieDetailModuleFactory
    }
    
    func createSearchMovieCoordinator(navigationController: UINavigationController) -> Coordinator {
        let coordinator = DefaultSearchMovieCoordinator(navigationController: navigationController,
                                                        searchMovieComponentsFactory: searchMovieComponentsFactory,
                                                        movieDetailModuleFactory: movieDetailModuleFactory)
        return coordinator
    }
}
