//
//  DefaultMovieDetailModuleFactory.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 11/4/23.
//

import Foundation
import UIKit

class DefaultMovieDetailModuleFactory: MovieDetailModuleFactory {
    
    private let networkService: DataTransferService
    
    init(networkService: DataTransferService) {
        self.networkService = networkService
    }
    
    func createMovieDetailCoordinator(navigationController: UINavigationController, completion: @escaping () -> Void) -> MovieDetailCoordinator {
        let factory = DefaultMovieDetailComponentFactory(networkService: networkService)
        let coordinator = DefaultMovieDetailCoordinator(navigationController: navigationController, componentFactory: factory)
        coordinator.onFinish = completion
        return coordinator
    }
}
