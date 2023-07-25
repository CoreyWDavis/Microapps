//
//  PlanetsListView.swift
//
//
//  Created by Corey Davis on 7/16/23.
//

import SwiftUI
import Combine
import DesignKit
import PlatformKit

class PlanetsListViewModel: ObservableObject {
    enum State {
        case idle
        case loading
    }
    
    @Published var planets: [PlanetModel]
    @Published var state: State
    
    init(planets: [PlanetModel] = [], state: State = .idle) {
        self.planets = planets
        self.state = state
    }
}

struct PlanetsListView: View {
    @ObservedObject var model: PlanetsListViewModel
    var route = PassthroughSubject<PlanetRoute, Never>()
    
    var body: some View {
        if #available(iOS 14, *) {
            ZStack {
                List {
                    ForEach(model.planets) { planet in
                        NavigationCellView(name: planet.name)
                            .foregroundColor(model.state == .loading ? .gray : nil)
                            .onTapGesture {
                                route.send(.planetDetail(for: planet.url))
                            }
                            .disabled(model.state == .loading)
                    }
                }
                if model.state == .loading {
                    ProgressView()
                }
            }
            .navigationTitle("Planets")
        } else {
            fatalError("View not available in iOS 13 or below")
        }
    }
}

struct PlanetsListView_Previews: PreviewProvider {
    static let mock = PlanetModel.mock()
    static let model = PlanetsListViewModel(planets: [mock])
    static var previews: some View {
        NavigationView {
            PlanetsListView(model: model)
        }
    }
}

