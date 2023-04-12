//
//  DefaultSearchModuleFactory.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 12/4/23.
//

import Foundation
import UIKit

class DefaultSearchModuleFactory: SearchModuleFactory {
    private let searchMovieComponentsFactory: SearchMovieComponentsFactory
    private let movieDetailModuleFactory: MovieDetailModuleFactory
    
    init(searchMovieComponentsFactory: SearchMovieComponentsFactory, movieDetailModuleFactory: MovieDetailModuleFactory) {
        self.searchMovieComponentsFactory = searchMovieComponentsFactory
        self.movieDetailModuleFactory = movieDetailModuleFactory
    }
    
    func createSearchMovieCoordinator(navigationController: UINavigationController) -> SearchMovieCoordinator {
        let coordinator = DefaultSearchMovieCoordinator(navigationController: navigationController,
                                                        searchMovieComponentsFactory: searchMovieComponentsFactory,
                                                        movieDetailModuleFactory: movieDetailModuleFactory)
        return coordinator
    }
}
