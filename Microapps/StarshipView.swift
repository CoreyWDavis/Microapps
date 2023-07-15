//
//  StarshipView.swift
//  Microapps
//
//  Created by Corey Davis on 7/15/23.
//

import SwiftUI

class StarshipViewModel: ObservableObject {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

struct StarshipView: View {
    @ObservedObject var model: StarshipViewModel

    var body: some View {
        Form {
            LabeledContent("Name", value: model.name)
        }
    }
}

struct StarshipView_Previews: PreviewProvider {
    static var previews: some View {
        StarshipView(model: StarshipViewModel(name: StarshipModel.mock().name))
    }
}
