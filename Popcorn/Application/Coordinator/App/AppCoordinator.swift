//
//  AppCoordinator.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 9/4/23.
//

import Foundation
import UIKit

public enum AppChildCoordinator {
    case main
}

class AppCoordinator: Coordinator {
    private let window: UIWindow
    private var childCoordinators = [AppChildCoordinator: Coordinator]()
    private let mainModuleFactory: MainModuleFactory
    
    init(window: UIWindow, mainModuleFactory: MainModuleFactory) {
        self.window = window
        self.mainModuleFactory = mainModuleFactory
    }
    
    func start() {
        let navigationController = UINavigationController()
        navigationController.navigationBar.barStyle = .black
        
        let homeCoordinator = mainModuleFactory.createMainCoordinator(navigationController: navigationController)
        
        childCoordinators[.main] = homeCoordinator
        homeCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
