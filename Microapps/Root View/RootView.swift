//
//  MainMenuView.swift
//  Microapps
//
//  Created by Corey Davis on 7/15/23.
//

import SwiftUI
import Combine

class RootViewModel: ObservableObject {
    enum State {
        case idle
        case loading
    }
    
    @Published var state: State
    
    init(state: State = .idle) {
        self.state = state
    }
}

struct RootView: View {
    @ObservedObject var model: RootViewModel
    var route = PassthroughSubject<AppRoute, Never>()
    var isVisble = PassthroughSubject<Bool, Never>()
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                Button("Starships") { route.send(.starships) }
                    .padding(.top, 16)
                Button("Planets") { route.send(.planets) }
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
        RootView(model: RootViewModel())
        RootView(model: RootViewModel(state: .loading))
    }
}
