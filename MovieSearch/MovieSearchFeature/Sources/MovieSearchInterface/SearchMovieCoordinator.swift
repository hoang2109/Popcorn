//
//  SearchCoordinator.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 12/4/23.
//

import Foundation
import Common

public enum SearchMovieStep: Step {
    case search
    case detail(Int)
}

public protocol SearchMovieCoordinator: NavigationCoordinator {
    func navigate(to step: SearchMovieStep)
}
