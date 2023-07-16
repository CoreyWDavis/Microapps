//
//  Coordinator.swift
//  Microapps
//
//  Created by Corey Davis on 7/15/23.
//

import UIKit

protocol Coordinator {
    var children: [Coordinator] { get }
    
    func start()
    func stop()
}

protocol NavigationCoordinator: Coordinator {
    var navigation: UINavigationController { get }
}
