//
//  DefaultMovieDetailModuleFactory.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 11/4/23.
//

import Foundation
import UIKit
import MovieDetailInterface
import Common

public class DefaultMovieDetailModuleFactory: MovieDetailModuleFactory {
    
    private let movieDetailComponentFactory: MovieDetailComponentFactory
    
    public init(movieDetailComponentFactory: MovieDetailComponentFactory) {
        self.movieDetailComponentFactory = movieDetailComponentFactory
    }
    
    public func createMovieDetailCoordinator(movieId: Int?, navigationController: UINavigationController, completion: @escaping () -> Void) -> MovieDetailCoordinator {
        let coordinator = DefaultMovieDetailCoordinator(movieId: movieId, navigationController: navigationController, componentFactory: movieDetailComponentFactory)
        coordinator.onFinish = completion
        return coordinator
    }
}
