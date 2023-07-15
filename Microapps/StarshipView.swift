//
//  StarshipView.swift
//  Microapps
//
//  Created by Corey Davis on 7/15/23.
//

import SwiftUI

class StarshipViewModel: ObservableObject {
    var name: String
    var model: String
    var starshipClass: String
    var crewCount: String
    var passengerCount: String
    var hyperdriveRating: String
    var url: String
    
    init(name: String, model: String, starshipClass: String, crewCount: String, passengerCount: String, hyperdriveRating: String, url: String) {
        self.name = name
        self.model = model
        self.starshipClass = starshipClass
        self.crewCount = crewCount
        self.passengerCount = passengerCount
        self.hyperdriveRating = hyperdriveRating
        self.url = url
    }
    
    init(model: StarshipModel) {
        name = model.name
        self.model = model.model
        starshipClass = model.starshipClass
        crewCount = model.crew
        passengerCount = model.passengers
        hyperdriveRating = model.hyperdriveRating
        url = model.url
    }
}

struct StarshipView: View {
    @ObservedObject var model: StarshipViewModel

    var body: some View {
        Form {
            Section(content: {
                LabeledContent("Model", value: model.model)
                LabeledContent("Class", value: model.starshipClass)
                LabeledContent("Crew", value: model.crewCount)
                LabeledContent("Pasenger", value: model.passengerCount)
                LabeledContent("Hyperdrive Rating", value: model.hyperdriveRating)
            }, footer: {
                Text(model.url)
            })
        }
        .navigationTitle(model.name)
    }
}

struct StarshipView_Previews: PreviewProvider {
    static let mock = StarshipModel.mock()
    static let model = StarshipViewModel(model: mock)
    static var previews: some View {
        NavigationView {
            StarshipView(model: model)            
        }
    }
}
