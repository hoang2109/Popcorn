//
//  DefaultMainCoordinator.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 10/4/23.
//

import Foundation
import UIKit

class DefaultMainCoordinator: MainCoordinator {
    
    let navigationController: UINavigationController
    private let componentsFactory: MainComponentsFactory
    private let movieDetailModuleFactory: MovieDetailModuleFactory
    private var childCoordinators = [UUID: Coordinator]()
    
    init(navigationController: UINavigationController, componentsFactory: MainComponentsFactory, movieDetailModuleFactory: MovieDetailModuleFactory) {
        self.navigationController = navigationController
        self.componentsFactory = componentsFactory
        self.movieDetailModuleFactory = movieDetailModuleFactory
    }
    
    func start() {
        navigate(to: .home)
    }
    
    // MARK: - Navigation
    func navigate(to step: MainStep) {
        switch step {
        case .home:
            navigateToHomeViewController()
            break
        case .movieCategory(let cateId, let title):
            navigateToMovieListController(cateId, title)
            break
        case .movieDetail(let movieId):
            navigateToMovieDetailModule(movieId)
            break
        }
    }
    
    private func navigateToHomeViewController() {
        let vc = componentsFactory.createHomeViewController(coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func navigateToMovieListController(_ cateId: String, _ title: String) {
        let vc = componentsFactory.createMovieListViewController(with: cateId, coordinator: self)
        vc.title = title
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func navigateToMovieDetailModule(_ movieId: Int) {
        let uuid = UUID()
        let coordinator = movieDetailModuleFactory.createMovieDetailCoordinator(movieId: movieId, navigationController: navigationController) { [weak self] in
            self?.childCoordinators[uuid] = nil
        }
        childCoordinators[uuid] = coordinator
        coordinator.start()
    }
}
