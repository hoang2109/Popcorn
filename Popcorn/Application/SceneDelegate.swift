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
    
    var nav = UINavigationController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let appDIContainer = AppDIContainer(appConfiguration: DefaultAppConfiguration())
        appCoordinator = AppCoordinator(window: window!, appDIContainer: appDIContainer)
        appCoordinator.start()
    }
}

