//
//  PlanetDetailView.swift
//  
//
//  Created by Corey Davis on 7/24/23.
//

import SwiftUI
import PlatformKit

class PlanetDetailViewModel: ObservableObject {
    var name: String
    var rotationPeriod: String
    var orbitalPeriod: String
    var diameter: String
    var climate: String
    var gravity: String
    var terrain: String
    var surfaceWater: String
    var population: String
    var url: String
    
    init(name: String, rotationPeriod: String, orbitalPeriod: String, diameter: String, climate: String, gravity: String, terrain: String, surfaceWater: String, population: String, url: String) {
        self.name = name
        self.rotationPeriod = rotationPeriod
        self.orbitalPeriod = orbitalPeriod
        self.diameter = diameter
        self.climate = climate
        self.gravity = gravity
        self.terrain = terrain
        self.surfaceWater = surfaceWater
        self.population = population
        self.url = url
    }
    
    init(model: PlanetModel) {
        name = model.name
        rotationPeriod = model.rotationPeriod
        orbitalPeriod = model.orbitalPeriod
        diameter = model.diameter
        climate = model.climate
        gravity = model.gravity
        terrain = model.terrain
        surfaceWater = model.surfaceWater
        population = model.population
        url = model.url
    }
}

struct PlanetDetailView: View {
    @ObservedObject var model: PlanetDetailViewModel
    
    var body: some View {
        if #available(iOS 16, *) {
            Form {
                Section(content: {
                    LabeledContent("Climate", value: model.climate.capitalized)
                    LabeledContent("Terrain", value: model.terrain.capitalized)
                    LabeledContent("Diameter", value: model.diameter)
                    LabeledContent("Gravity", value: model.gravity.capitalized)
                    LabeledContent("Surface Water", value: model.surfaceWater)
                    LabeledContent("Orbital Period", value: model.orbitalPeriod)
                    LabeledContent("Rotation Period", value: model.rotationPeriod)
                    LabeledContent("Population", value: model.population)
                }, footer: {
                    Text(model.url)
                })
            }
            .navigationTitle(model.name)
        } else {
            fatalError("View not availing in iOS 15 or below")
        }
    }
}

struct StarshipDetailView_Previews: PreviewProvider {
    static let mock = PlanetModel.mock()
    static let model = PlanetDetailViewModel(model: mock)
    static var previews: some View {
        NavigationView {
            PlanetDetailView(model: model)
        }
    }
}
