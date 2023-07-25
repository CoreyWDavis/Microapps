//
//  PlanetCoordinator.swift
//  
//
//  Created by Corey Davis on 7/24/23.
//

import UIKit
import SwiftUI
import Combine
import CoreKit
import PlatformKit

public class PlanetCoordinator: NavigationCoordinator {
    public var delegate: CoordinatorDelegate?
    public var navigation: UINavigationController
    var subscriptions = Set<AnyCancellable>()
    var listViewModel: PlanetsListViewModel?
    
    public init(navigationController: UINavigationController) {
        self.navigation = navigationController
    }
    
    @MainActor
    public func start() -> UIViewController {
        print("Starting...")
        defer { print("Started") }
        navigate(to: .planetsList)
        return navigation
    }
    
    public func stop() {
        print("Stopping...")
        print("Stopped")
    }
    
    @MainActor
    private func navigate(to route: PlanetRoute) {
        switch route {
        case .planetDetail(let url):
            Task {
                defer { listViewModel?.state = .idle }
                listViewModel?.state = .loading
                guard let view = await makePlanetDetailView(url: url) else { return }
                navigation.pushViewController(view, animated: true)
            }
        case .planetsList:
            Task {
                guard let view = await makePlanetsListView() else { return }
                navigation.pushViewController(view, animated: true)
                listViewModel?.state = .loading
                defer { listViewModel?.state = .idle }
                guard let model = await PlanetsModel.fetch() else {
                    print("Error making planets view")
                    return
                }
                listViewModel?.planets = model.results
            }
        }
    }
    
    @MainActor
    private func makePlanetDetailView(url: String) async -> UIViewController? {
        guard
            let lastComponent = url.split(separator: "/").last,
            let id = Int(lastComponent),
            let model = await PlanetModel.fetch(id: id)
        else {
            print("Error making planet detail view")
            return nil
        }
        let viewModel = PlanetDetailViewModel(model: model)
        let view = PlanetDetailView(model: viewModel)
        return UIHostingController(rootView: view)
    }
    
    @MainActor
    private func makePlanetsListView() async -> UIViewController? {
        let viewModel = PlanetsListViewModel()
        listViewModel = viewModel
        let view = PlanetsListView(model: viewModel)
        view.route
            .receive(on: RunLoop.main)
            .sink { [weak self] route in
                self?.navigate(to: route)
            }
            .store(in: &subscriptions)
        return UIHostingController(rootView: view)
    }
}
