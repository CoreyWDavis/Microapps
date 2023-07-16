//
//  StarshipsListView.swift
//  Microapps
//
//  Created by Corey Davis on 7/16/23.
//

import SwiftUI
import Combine

class StarshipsListViewModel: ObservableObject {
    enum State {
        case idle
        case loading
    }
    
    @Published var starships: [StarshipModel]
    @Published var state: State
    
    init(starships: [StarshipModel] = [], state: State = .idle) {
        self.starships = starships
        self.state = state
    }
}

struct StarshipsListView: View {
    @ObservedObject var model: StarshipsListViewModel
    var route = PassthroughSubject<StarshipRoute, Never>()
    
    var body: some View {
        ZStack {
            List {
                ForEach(model.starships) { starship in
                    cellView(starship)
                }
            }
            if model.state == .loading {
                ProgressView()
            }
        }
        .navigationTitle("Starships")
    }
    
    private func cellView(_ starship: StarshipModel) -> some View {
        HStack {
            Text(starship.name)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .foregroundColor(model.state == .loading ? .gray : nil)
        .onTapGesture {
            route.send(.starshipDetail(for: starship.url))
        }
        .disabled(model.state == .loading)
    }
}

struct StarshipsListView_Previews: PreviewProvider {
    static let mock = StarshipModel.mock()
    static let model = StarshipsListViewModel(starships: [mock])
    static let busyModel = StarshipsListViewModel(starships: [mock], state: .loading)
    static var previews: some View {
        NavigationView {
            StarshipsListView(model: model)
        }
        NavigationView {
            StarshipsListView(model: busyModel)
        }
    }
}
