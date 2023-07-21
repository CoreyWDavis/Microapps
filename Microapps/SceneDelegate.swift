//
//  SceneDelegate.swift
//  Microapps
//
//  Created by Corey Davis on 7/15/23.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator = AppCoordinator()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator.start()
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }
}

