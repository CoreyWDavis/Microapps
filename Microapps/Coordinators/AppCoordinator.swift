//
//  AppCoordinator.swift
//  Microapps
//
//  Created by Corey Davis on 7/15/23.
//

import UIKit
import SwiftUI
import Combine

class AppCoordinator: NavigationCoordinator {
    weak var delegate: CoordinatorDelegate?
    var navigation = UINavigationController()
    var children: [Coordinator] = []
    var subscriptions = Set<AnyCancellable>()
    private var rootViewModel: MainMenuViewModel?
    
    @MainActor
    func start() {
        print("Starting...")
        navigate(to: .rootView)
        print("Started")
    }
    
    func stop() {
        print("Stopping...")
        dismissAllChildren()
        print("Stopped")
    }
    
    @MainActor
    private func navigate(to route: AppRoute) {
        switch route {
        case .rootView:
            let rootView = makeRootView()
            navigation = makeNavigation(rootView: rootView)
        case .starships:
            let starshipsCoordinator = StarshipsCoordinator(navigationController: navigation)
            starshipsCoordinator.delegate = self
            children.append(starshipsCoordinator)
            starshipsCoordinator.start()
        }
    }
    
    @MainActor
    private func makeRootView() -> UIViewController {
        let model = MainMenuViewModel()
        rootViewModel = model
        let view = MainMenuView(model: model)
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
                self?.dismissAllChildren()
            }
            .store(in: &subscriptions)
        return UIHostingController(rootView: view)
    }
}

extension AppCoordinator: CoordinatorDelegate {
    func coordinatorDidStart(_ coordinator: Coordinator) {}
    
    func coordinatorDidStop(_ coordinator: Coordinator) {
        children
            .filter { $0 === coordinator }
            .forEach {
                $0.stop()
            }
        children.removeAll { $0 === coordinator }
    }
}
