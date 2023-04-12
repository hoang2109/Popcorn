//
//  DefaultMainModuleFactory.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 11/4/23.
//

import Foundation
import UIKit

class DefaultMainModuleFactory: MainModuleFactory {
    
    private let mainComponentsFactory: MainComponentsFactory
    private let movieDetailModuleFactory: MovieDetailModuleFactory
    
    init(mainComponentsFactory: MainComponentsFactory, movieDetailModuleFactory: MovieDetailModuleFactory) {
        self.mainComponentsFactory = mainComponentsFactory
        self.movieDetailModuleFactory = movieDetailModuleFactory
    }
    
    func createMainCoordinator(navigationController: UINavigationController) -> MainCoordinator {
        let homeCoordinator = DefaultMainCoordinator(navigationController: navigationController,
                                                     componentsFactory: mainComponentsFactory,
                                                     movieDetailModuleFactory: movieDetailModuleFactory
        )
        return homeCoordinator
    }
}
