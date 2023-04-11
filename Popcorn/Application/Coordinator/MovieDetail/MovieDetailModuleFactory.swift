//
//  MovieDetailModuleFactory.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 11/4/23.
//

import UIKit

protocol MovieDetailModuleFactory {
    func createMovieDetailCoordinator(navigationController: UINavigationController, completion: @escaping () -> Void) -> MovieDetailCoordinator
}
