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
    private let appDIContainer: AppDIContainer
    
    init(window: UIWindow, appDIContainer: AppDIContainer) {
        self.window = window
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let navigationController = UINavigationController()
        navigationController.navigationBar.barStyle = .black
        
        let homeComponentsFactory = DefaultMainComponentsFactory(networkService: appDIContainer.networkService)
        let homeCoordinator = DefaultMainCoordinator(navigationController: navigationController, componentsFactory: homeComponentsFactory)
        
        childCoordinators[.main] = homeCoordinator
        homeCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}