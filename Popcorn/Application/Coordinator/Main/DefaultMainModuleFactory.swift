//
//  DefaultMainModuleFactory.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 11/4/23.
//

import Foundation
import UIKit

class DefaultMainModuleFactory: MainModuleFactory {
    
    private let networkService: DataTransferService
    
    init(networkService: DataTransferService) {
        self.networkService = networkService
    }
    
    func createMainCoordinator(navigationController: UINavigationController) -> MainCoordinator {
        let homeComponentsFactory = DefaultMainComponentsFactory(networkService: networkService)
        let detailModuleFactory = DefaultMovieDetailModuleFactory(networkService: networkService)
        let homeCoordinator = DefaultMainCoordinator(navigationController: navigationController,
                                                     componentsFactory: homeComponentsFactory,
                                                     movieDetailModuleFactory: detailModuleFactory
        )
        return homeCoordinator
    }
}
