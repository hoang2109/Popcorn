//
//  DefaultSearchModuleFactory.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 12/4/23.
//

import Foundation
import UIKit
import MovieDetailInterface
import Common
import MovieSearchInterface

public class DefaultSearchModuleFactory: SearchModuleFactory {
    private let searchMovieComponentsFactory: SearchMovieComponentsFactory
    private let movieDetailModuleFactory: MovieDetailModuleFactory
    
    public init(searchMovieComponentsFactory: SearchMovieComponentsFactory, movieDetailModuleFactory: MovieDetailModuleFactory) {
        self.searchMovieComponentsFactory = searchMovieComponentsFactory
        self.movieDetailModuleFactory = movieDetailModuleFactory
    }
    
    public func createSearchMovieCoordinator(navigationController: UINavigationController) -> Coordinator {
        let coordinator = DefaultSearchMovieCoordinator(navigationController: navigationController,
                                                        searchMovieComponentsFactory: searchMovieComponentsFactory,
                                                        movieDetailModuleFactory: movieDetailModuleFactory)
        return coordinator
    }
}
