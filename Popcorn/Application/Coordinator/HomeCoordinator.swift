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
}

class HomeCoordinator: NavigationCoordinator {
    struct Dependencies {
        let networkService: DataTransferService
    }
    
    let navigationController: UINavigationController
    private let dependencies: Dependencies
    
    init(navigationController: UINavigationController, dependencies: Dependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        navigate(to: .home)
    }
    
    // MARK: - Navigation
    func navigate(to step: HomeStep) {
        switch step {
        case .home:
            let vc = HomeUIComposer.compose(dependencies.networkService, self)
            navigationController.pushViewController(vc, animated: true)
            break
        case .movieDetail(let movieId):
            let vc = MovieDetailUIComposer.compose(movieId, dependencies.networkService, self)
            navigationController.pushViewController(vc, animated: true)
            break
        case .actorDetail(let actorId):
            let vc = ActorDetailUIComposer.compose(actorId, dependencies.networkService, self)
            navigationController.present(vc, animated: true)
            break
        }
    }
}

extension HomeCoordinator: HomeViewControllerDelegate, ActorDetailViewControllerDelegate {
    func didSelectMovie(_ movieId: Int) {
        if let _ = self as ActorDetailViewControllerDelegate? {
            navigationController.dismiss(animated: true)
        }
        navigate(to: .movieDetail(movieId))
    }
}

extension HomeCoordinator: MovieDetailViewControllerDelegate {
    func didSelectActor(_ actorId: Int) {
        navigate(to: .actorDetail(actorId))
    }
}
