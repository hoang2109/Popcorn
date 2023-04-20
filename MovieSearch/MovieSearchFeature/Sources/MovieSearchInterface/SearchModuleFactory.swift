//
//  SearchModuleFactory.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 12/4/23.
//

import Foundation
import UIKit
import Common

public protocol SearchModuleFactory {
    func createSearchMovieCoordinator(navigationController: UINavigationController) -> SearchMovieCoordinator
}
