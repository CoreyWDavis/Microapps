//
//  Coordinator.swift
//  Microapps
//
//  Created by Corey Davis on 7/15/23.
//

import UIKit

protocol CoordinatorDelegate: AnyObject {
    func coordinatorDidStart(_ coordinator: Coordinator)
    func coordinatorDidStop(_ coordinator: Coordinator)
}

protocol Coordinator: AnyObject {
    var delegate: CoordinatorDelegate? { get set }
    var children: [Coordinator] { get set }
    
    func start()
    func stop()
}

protocol NavigationCoordinator: Coordinator {
    var navigation: UINavigationController { get }
}

extension NavigationCoordinator {
    func makeNavigation(rootView: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootView)
        nav.navigationBar.prefersLargeTitles = true
        return nav
    }
    
    func dismissAllChildren() {
        children.forEach { $0.stop() }
        children.removeAll()
    }
}
