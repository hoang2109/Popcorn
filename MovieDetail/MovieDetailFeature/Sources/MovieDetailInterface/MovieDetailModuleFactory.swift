//
//  MovieDetailModuleFactory.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 11/4/23.
//

import UIKit

public protocol MovieDetailModuleFactory {
    func createMovieDetailCoordinator(movieId: Int?, navigationController: UINavigationController, completion: @escaping () -> Void) -> MovieDetailCoordinator
}
