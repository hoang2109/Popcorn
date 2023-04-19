//
//  HomeCoordinator.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 9/4/23.
//

import Foundation
import UIKit

// MARK: - Steps
public enum HomeStep: Step {
    case home
    case movieDetail(Int)
    case actorDetail(Int)
    case dismiss
}

protocol MainCoordinator: NavigationCoordinator {
    func navigate(to step: HomeStep)
}

class DefaultHomeCoordinator: MainCoordinator {
    
    let navigationController: UINavigationController
    private let componentsFactory: HomeComponentsFactory
    
    init(navigationController: UINavigationController, componentsFactory: HomeComponentsFactory) {
        self.navigationController = navigationController
        self.componentsFactory = componentsFactory
    }
    
    func start() {
        navigate(to: .home)
    }
    
    // MARK: - Navigation
    func navigate(to step: HomeStep) {
        switch step {
        case .home:
            let vc = componentsFactory.createHomeViewController(coordinator: self)
            navigationController.pushViewController(vc, animated: true)
            break
        case .movieDetail(let movieId):
            let vc = componentsFactory.createMovieDetailViewController(with: movieId, coordinator: self)
            navigationController.pushViewController(vc, animated: true)
            break
        case .actorDetail(let actorId):
            let vc = componentsFactory.createActorDetailViewController(with: actorId, coordinator: self)
            navigationController.present(vc, animated: true)
            break
        case .dismiss:
            navigationController.dismiss(animated: true)
            break
        }
    }
}
