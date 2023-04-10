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
    
    init(navigationController: UINavigationController, componentsFactory: MainComponentsFactory) {
        self.navigationController = navigationController
        self.componentsFactory = componentsFactory
    }
    
    func start() {
        navigate(to: .home)
    }
    
    // MARK: - Navigation
    func navigate(to step: MainStep) {
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
