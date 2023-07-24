//
//  AppCoordinator.swift
//  Microapps
//
//  Created by Corey Davis on 7/15/23.
//

import UIKit
import SwiftUI
import Combine
import CoreKit
import StarshipKit
import PlanetKit

class AppCoordinator: NavigationCoordinator {
    weak var delegate: CoordinatorDelegate?
    private(set) var navigation = UINavigationController()
    private(set) var children: [Coordinator] = []
    var subscriptions = Set<AnyCancellable>()
    
    @MainActor
    func start() -> UIViewController {
        print("Starting...")
        navigation = makeNavigation(rootView: makeRootView())
        print("Started")
        return navigation
    }
    
    func stop() {
        print("Stopping...")
        dismissAllChildren()
        print("Stopped")
    }
    
    @MainActor
    private func navigate(to route: AppRoute) {
        switch route {
        case .starships:
            let starshipsCoordinator = StarshipsCoordinator(navigationController: navigation)
            starshipsCoordinator.delegate = self
            children.append(starshipsCoordinator)
            _ = starshipsCoordinator.start()
        case .planets:
            let planetsCoordinator = PlanetCoordinator(navigationController: navigation)
            planetsCoordinator.delegate = self
            children.append(planetsCoordinator)
            _ = planetsCoordinator.start()
        }
    }
    
    @MainActor
    private func makeRootView() -> UIViewController {
        let view = RootView()
        view.route
            .subscribe(on: RunLoop.main)
            .sink { [weak self] route in
                self?.navigate(to: route)
            }
            .store(in: &subscriptions)
        view.isVisble
            .subscribe(on: RunLoop.main)
            .sink { [weak self] visible in
                guard visible else { return }
                // If root view is visible then the children have been dismissed
                // and can be removed from the `children` array
                self?.dismissAllChildren()
            }
            .store(in: &subscriptions)
        return UIHostingController(rootView: view)
    }
    
    func dismissAllChildren() {
        children.forEach { $0.stop() }
        children.removeAll()
    }
}

extension AppCoordinator: CoordinatorDelegate {
    func coordinatorDidStart(_ coordinator: Coordinator) {}
    
    func coordinatorDidStop(_ coordinator: Coordinator) {
        children.removeAll { $0 === coordinator }
    }
}
