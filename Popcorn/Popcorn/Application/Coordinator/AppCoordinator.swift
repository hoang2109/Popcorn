//
//  AppCoordinator.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 9/4/23.
//

import Foundation
import UIKit
import Common
import MoviePopularInterface
import MovieSearchInterface

public enum AppChildCoordinator {
    case main
    case search
}

class AppCoordinator: Coordinator {
    private let window: UIWindow
    private var childCoordinators = [AppChildCoordinator: Coordinator]()
    private let mainModuleFactory: MainModuleFactory
    private let searchModuleFactory: SearchModuleFactory
    
    init(window: UIWindow,
         mainModuleFactory: MainModuleFactory,
         searchModuleFactory: SearchModuleFactory) {
        self.window = window
        self.mainModuleFactory = mainModuleFactory
        self.searchModuleFactory = searchModuleFactory
    }
    
    func start() {
        let tabBar = UITabBarController()
        tabBar.tabBar.barStyle = .black
        tabBar.tabBar.barTintColor = .black
        tabBar.tabBar.tintColor = .white
        
        let homeNavigationController = createHomeNavigationController()
        let searchNavigationController = createSearchNavigationController()
        
        tabBar.setViewControllers([homeNavigationController, searchNavigationController], animated: true)
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
    }
    
    private func createHomeNavigationController() -> UINavigationController {
        let homeNavigationController = UINavigationController()
        homeNavigationController.hidesBottomBarWhenPushed = true
        homeNavigationController.navigationBar.barStyle = .black
        homeNavigationController.tabBarItem = UITabBarItem(title: "Movies",
                                                  image: UIImage(named: "film-reel"), tag: 0)
        let homeCoordinator = mainModuleFactory.createMainCoordinator(navigationController: homeNavigationController)
        
        childCoordinators[.main] = homeCoordinator
        homeCoordinator.start()
        return homeNavigationController
    }
    
    private func createSearchNavigationController() -> UINavigationController {
        let searchNavigationController = UINavigationController()
        searchNavigationController.hidesBottomBarWhenPushed = true
        searchNavigationController.navigationBar.barStyle = .black
        searchNavigationController.tabBarItem = UITabBarItem(title: "Search",
                                                  image: UIImage(named: "search"), tag: 1)
        let homeCoordinator = searchModuleFactory.createSearchMovieCoordinator(navigationController: searchNavigationController)
        
        childCoordinators[.search] = homeCoordinator
        homeCoordinator.start()
        return searchNavigationController
    }
}
