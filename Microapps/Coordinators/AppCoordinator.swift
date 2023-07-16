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
    private var rootViewModel: MainMenuViewModel?
    private var starshipsListViewModel: StarshipsListViewModel?
    
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
        case .starships:
            navigate(to: .starshipsList)
        }
    }
    
    @MainActor
    private func navigate(to route: StarshipRoute) {
        switch route {
        case .starshipDetail(let url):
            Task {
                defer { starshipsListViewModel?.state = .idle }
                starshipsListViewModel?.state = .loading
                guard let view = await makeStarshipDetailView(url: url) else { return }
                navigation.pushViewController(view, animated: true)
            }
        case .starshipsList:
            Task {
                defer { rootViewModel?.state = .idle }
                rootViewModel?.state = .loading
                guard let view = await makeStarshipsListView() else { return }
                navigation.pushViewController(view, animated: true)
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
        rootViewModel = model
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
    private func makeStarshipDetailView(url: String) async -> UIViewController? {
        guard
            let lastComponent = url.split(separator: "/").last,
            let shipID = Int(lastComponent),
            let model = await StarshipModel.fetch(id: shipID)
        else {
            print("Error making starships view")
            return nil
        }
        let viewModel = StarshipDetailViewModel(model: model)
        let view = StarshipDetailView(model: viewModel)
        return UIHostingController(rootView: view)
    }
    
    @MainActor
    private func makeStarshipsListView() async -> UIViewController? {
        guard let model = await StarshipsModel.fetch() else {
            print("Error making starships view")
            return nil
        }
        let viewModel = StarshipsListViewModel(starships: model.results)
        starshipsListViewModel = viewModel
        let view = StarshipsListView(model: viewModel)
        view.route
            .receive(on: RunLoop.main)
            .sink { [weak self] route in
                self?.navigate(to: route)
            }
            .store(in: &subscriptions)
        return UIHostingController(rootView: view)
    }
}
