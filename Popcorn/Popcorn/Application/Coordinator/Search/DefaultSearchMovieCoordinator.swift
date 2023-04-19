//
//  DefaultSearchMovieCoordinator.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 12/4/23.
//

import Foundation
import UIKit
import MovieDetailInterface

class DefaultSearchMovieCoordinator: SearchMovieCoordinator {
    var navigationController: UINavigationController
    private let searchMovieComponentsFactory: SearchMovieComponentsFactory
    private let movieDetailModuleFactory: MovieDetailInterface.MovieDetailModuleFactory
    private var childCoordinators = [UUID: MovieDetailInterface.Coordinator]()
    
    init(navigationController: UINavigationController, searchMovieComponentsFactory: SearchMovieComponentsFactory, movieDetailModuleFactory: MovieDetailInterface.MovieDetailModuleFactory) {
        self.navigationController = navigationController
        self.searchMovieComponentsFactory = searchMovieComponentsFactory
        self.movieDetailModuleFactory = movieDetailModuleFactory
    }
    
    func start() {
        navigate(to: .search)
    }
    
    func navigate(to step: SearchMovieStep) {
        switch step {
        case .search:
            navigateToSearchMovieViewController()
        case let .detail(movieId):
            navigateToMovieDetail(movieId)
        }
    }
    
    private func navigateToSearchMovieViewController() {
        let vc = searchMovieComponentsFactory.createSearchMovieViewController(coordinator: self)
        vc.title = "Search"
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func navigateToMovieDetail(_ movieId: Int) {
        let uuid = UUID()
        let coordinator = movieDetailModuleFactory.createMovieDetailCoordinator(movieId: movieId, navigationController: navigationController) { [weak self] in
            self?.childCoordinators[uuid] = nil
        }
        childCoordinators[uuid] = coordinator
        coordinator.start()
    }
}
