//
//  AppDelegate.swift
//  Microapps
//
//  Created by Corey Davis on 7/15/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        StarshipModel.fetch(id: 9) { model in
            print(model)
        }
        return true
    }
}

