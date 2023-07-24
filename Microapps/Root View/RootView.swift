//
//  MainMenuView.swift
//  Microapps
//
//  Created by Corey Davis on 7/15/23.
//

import SwiftUI
import Combine

struct RootView: View {
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
        }
        .navigationTitle("Main Menu")
        .onAppear {
            isVisble.send(true)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
