//
//  DefaultMovieDetailCoordinator.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 11/4/23.
//

import Foundation
import UIKit
import MovieDetailInterface

class DefaultMovieDetailCoordinator: MovieDetailCoordinator {
    var onFinish: (() -> Void)?
    
    var navigationController: UINavigationController
    private let componentFactory: MovieDetailComponentFactory
    private var movieId: Int?
    
    private var topViewController: UIViewController?
    
    init(movieId: Int? = nil, navigationController: UINavigationController, componentFactory: MovieDetailComponentFactory) {
        self.movieId = movieId
        self.navigationController = navigationController
        self.componentFactory = componentFactory
        
        topViewController = navigationController.topViewController
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
    func start() {
        if let movieId = movieId {
            navigate(to: .movieDetail(movieId))
        }
    }
    
    func navigate(to step: MovieDetailStep) {
        switch step {
        case let .movieDetail(movieId):
            navigateToMovieDetail(movieId)
        case let .actorDetail(actorId):
            navigateToActorDetail(actorId)
        case .dismissActorDetail:
            dismissActorDetail()
        case .movieDetailFinish:
            movieDetailCoordinatorDidFinish()
        }
    }
    
    private func navigateToMovieDetail(_ movieId: Int) {
        let vc = componentFactory.createMovieDetailViewController(with: movieId, coordinator: self)
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func navigateToActorDetail(_ actorId: Int) {
        let vc = componentFactory.createActorDetailViewController(with: actorId, coordinator: self)
        navigationController.present(vc, animated: true)
    }
    
    private func dismissActorDetail() {
        navigationController.topViewController?.dismiss(animated: true)
    }
    
    private func movieDetailCoordinatorDidFinish() {
        if topViewController == navigationController.topViewController {
            onFinish?()
            topViewController = nil
        }
    }
}
