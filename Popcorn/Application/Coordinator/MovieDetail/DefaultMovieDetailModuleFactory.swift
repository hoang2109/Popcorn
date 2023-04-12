//
//  DefaultMovieDetailModuleFactory.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 11/4/23.
//

import Foundation
import UIKit

class DefaultMovieDetailModuleFactory: MovieDetailModuleFactory {
    
    private let movieDetailComponentFactory: MovieDetailComponentFactory
    
    init(movieDetailComponentFactory: MovieDetailComponentFactory) {
        self.movieDetailComponentFactory = movieDetailComponentFactory
    }
    
    func createMovieDetailCoordinator(navigationController: UINavigationController, completion: @escaping () -> Void) -> MovieDetailCoordinator {
        let coordinator = DefaultMovieDetailCoordinator(navigationController: navigationController, componentFactory: movieDetailComponentFactory)
        coordinator.onFinish = completion
        return coordinator
    }
}
