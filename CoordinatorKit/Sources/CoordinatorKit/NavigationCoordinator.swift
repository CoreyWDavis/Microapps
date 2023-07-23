//
//  NavigationCoordinator.swift
//  
//
//  Created by Corey Davis on 7/23/23.
//

import UIKit

public protocol NavigationCoordinator: Coordinator {
    var navigation: UINavigationController { get }
}

extension NavigationCoordinator {
    public func makeNavigation(rootView: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootView)
        nav.navigationBar.prefersLargeTitles = true
        return nav
    }
}
