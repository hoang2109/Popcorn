//
//  SceneDelegate.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 2/4/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!
    var appDIContainer: AppDIContainer!
    
    var nav = UINavigationController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        appDIContainer = AppDIContainer(appConfiguration: DefaultAppConfiguration())
        
        appCoordinator = AppCoordinator(window: window!, mainModuleFactory: DefaultMainModuleFactory(networkService: appDIContainer.networkService))
        appCoordinator.start()
    }
}

