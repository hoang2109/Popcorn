//
//  SearchMovieComponentsFactory.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 12/4/23.
//

import Foundation
import UIKit
import MovieSearchInterface

public protocol SearchMovieComponentsFactory {
    func createSearchMovieViewController(coordinator: SearchMovieCoordinator) -> UIViewController
}
