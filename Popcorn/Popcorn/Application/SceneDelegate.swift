//
//  SceneDelegate.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 2/4/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)

//        navController.setViewControllers([makePopularCollectionScene()], animated: true)
//        window.rootViewController = navController
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController")
        window.rootViewController = vc
        
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}

