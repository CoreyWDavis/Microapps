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
    var navigation = UINavigationController()
    var children: [Coordinator] = []
    var subscriptions = Set<AnyCancellable>()
    private var viewModel: MainMenuViewModel?
    
    @MainActor
    func start() {
        print("Starting")
        navigate(to: .rootView)
    }
    
    func stop() {
        print("Stopping")
    }
    
    @MainActor
    private func navigate(to route: AppRoute) {
        switch route {
        case .rootView:
            let rootView = makeRootView()
            navigation = makeNavigation(rootView: rootView)
        case .starshipDetail(let id):
            Task {
                viewModel?.state = .loading
                guard let view = await makeStarshipDetailView(forID: id) else { return }
                navigation.pushViewController(view, animated: true)
                viewModel?.state = .idle
            }
        }
    }
    
    private func makeNavigation(rootView: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootView)
        nav.navigationBar.prefersLargeTitles = true
        return nav
    }
    
    @MainActor
    private func makeRootView() -> UIViewController {
        let model = MainMenuViewModel()
        viewModel = model
        let view = MainMenuView(model: model)
        view.route
            .subscribe(on: RunLoop.main)
            .sink { [weak self] route in
                self?.navigate(to: route)
            }
            .store(in: &subscriptions)
        return UIHostingController(rootView: view)
    }
    
    @MainActor
    private func makeStarshipDetailView(forID id: Int) async -> UIViewController? {
        guard let model = await StarshipModel.fetch(id: id) else {
            print("Error making starships view")
            return nil
        }
        let viewModel = StarshipDetailViewModel(model: model)
        let view = StarshipDetailView(model: viewModel)
        return UIHostingController(rootView: view)
    }
}
