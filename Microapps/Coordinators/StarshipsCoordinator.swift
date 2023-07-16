//
//  StarshipsCoordinator.swift
//  Microapps
//
//  Created by Corey Davis on 7/16/23.
//

import UIKit
import SwiftUI
import Combine

class StarshipsCoordinator: NavigationCoordinator {
    weak var delegate: CoordinatorDelegate?
    var navigation: UINavigationController
    var children: [Coordinator] = []
    var subscriptions = Set<AnyCancellable>()
    private var listViewModel: StarshipsListViewModel?
    
    init(navigationController: UINavigationController) {
        self.navigation = navigationController
    }
    
    @MainActor
    func start() {
        print("Starting...")
        navigate(to: .starshipsList)
        print("Started")
    }
    
    func stop() {
        print("Stopping...")
        dismissAllChildren()
        print("Stopped")
    }
    
    @MainActor
    private func navigate(to route: StarshipRoute) {
        switch route {
        case .starshipDetail(let url):
            Task {
                defer { listViewModel?.state = .idle }
                listViewModel?.state = .loading
                guard let view = await makeStarshipDetailView(url: url) else { return }
                navigation.pushViewController(view, animated: true)
            }
        case .starshipsList:
            Task {
                guard let view = await makeStarshipsListView() else { return }
                navigation.pushViewController(view, animated: true)
                listViewModel?.state = .loading
                defer { listViewModel?.state = .idle }
                guard let model = await StarshipsModel.fetch() else {
                    print("Error making starships view")
                    return
                }
                listViewModel?.starships = model.results
            }
        }
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
        let viewModel = StarshipsListViewModel()
        listViewModel = viewModel
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
