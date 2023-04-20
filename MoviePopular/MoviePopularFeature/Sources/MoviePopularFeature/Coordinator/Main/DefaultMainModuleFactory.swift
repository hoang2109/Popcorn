//
//  DefaultMainModuleFactory.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 11/4/23.
//

import Foundation
import UIKit
import MovieDetailInterface
import Common
import MoviePopularInterface

public class DefaultMainModuleFactory: MainModuleFactory {
    
    private let mainComponentsFactory: MainComponentsFactory
    private let movieDetailModuleFactory: MovieDetailModuleFactory
    
    public init(mainComponentsFactory: MainComponentsFactory, movieDetailModuleFactory: MovieDetailModuleFactory) {
        self.mainComponentsFactory = mainComponentsFactory
        self.movieDetailModuleFactory = movieDetailModuleFactory
    }
    
    public func createMainCoordinator(navigationController: UINavigationController) -> Coordinator {
        let homeCoordinator = DefaultMainCoordinator(navigationController: navigationController,
                                                     componentsFactory: mainComponentsFactory,
                                                     movieDetailModuleFactory: movieDetailModuleFactory
        )
        return homeCoordinator
    }
}
