//
//  SearchCoordinator.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 12/4/23.
//

import Foundation

enum SearchMovieStep: Step {
    case search
    case detail(Int)
}

protocol SearchMovieCoordinator: NavigationCoordinator {
    func navigate(to step: SearchMovieStep)
}
