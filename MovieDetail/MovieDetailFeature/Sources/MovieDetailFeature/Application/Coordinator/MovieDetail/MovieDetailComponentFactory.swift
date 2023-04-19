//
//  MovieDetailComponentFactory.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 11/4/23.
//

import Foundation
import UIKit

public protocol MovieDetailComponentFactory {
    func createMovieDetailViewController(with movieId: Int, coordinator: MovieDetailCoordinator) -> UIViewController
    func createActorDetailViewController(with actorId: Int, coordinator: MovieDetailCoordinator) -> UIViewController
}
