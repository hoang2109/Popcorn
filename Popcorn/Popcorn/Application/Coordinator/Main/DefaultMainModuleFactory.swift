//
//  DefaultMainModuleFactory.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 11/4/23.
//

import Foundation
import UIKit
import MovieDetailInterface

class DefaultMainModuleFactory: MainModuleFactory {
    
    private let mainComponentsFactory: MainComponentsFactory
    private let movieDetailModuleFactory: MovieDetailInterface.MovieDetailModuleFactory
    
    init(mainComponentsFactory: MainComponentsFactory, movieDetailModuleFactory: MovieDetailInterface.MovieDetailModuleFactory) {
        self.mainComponentsFactory = mainComponentsFactory
        self.movieDetailModuleFactory = movieDetailModuleFactory
    }
    
    func createMainCoordinator(navigationController: UINavigationController) -> Coordinator {
        let homeCoordinator = DefaultMainCoordinator(navigationController: navigationController,
                                                     componentsFactory: mainComponentsFactory,
                                                     movieDetailModuleFactory: movieDetailModuleFactory
        )
        return homeCoordinator
    }
}
