//
//  SceneDelegate.swift
//  laboratory3
//
//  Created by Benjamin on 24/04/2020.
//  Copyright © 2020 Benjamin. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let moviesStore = MoviesStore()
        let navController = window!.rootViewController as! UINavigationController
        let moviesViewController = navController.topViewController as! MoviesViewController
        moviesViewController.moviesStore = moviesStore
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

