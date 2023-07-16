//
//  MainMenuView.swift
//  Microapps
//
//  Created by Corey Davis on 7/15/23.
//

import SwiftUI
import Combine

class MainMenuViewModel: ObservableObject {
    enum State {
        case idle
        case loading
    }
    
    @Published var state: State
    
    init(state: State = .idle) {
        self.state = state
    }
}

struct MainMenuView: View {
    @ObservedObject var model: MainMenuViewModel
    var route = PassthroughSubject<AppRoute, Never>()
    var isVisble = PassthroughSubject<Bool, Never>()
    
    var body: some View {
        ZStack {
            VStack {
                Button("Starships") { route.send(.starships) }
                Spacer()
            }
            .disabled(model.state == .loading)
            if model.state == .loading {
                ProgressView()
            }
        }
        .navigationTitle("Main Menu")
        .onAppear {
            isVisble.send(true)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(model: MainMenuViewModel())
        MainMenuView(model: MainMenuViewModel(state: .loading))
    }
}
