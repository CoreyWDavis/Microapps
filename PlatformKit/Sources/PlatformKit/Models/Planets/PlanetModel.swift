//
//  PlanetModel.swift
//  
//
//  Created by Corey Davis on 7/24/23.
//

import Foundation

public struct PlanetModel: Codable {
    /// The name of this planet
    public var name: String
    
    /// The diameter of this planet in kilometers
    public var diameter: String
    
    /// The number of standard hours it takes for this planet to complete a
    /// single rotation on its axis
    public var rotationPeriod: String
    
    /// The number of standard days it takes for this planet to complete a
    /// single orbit of its local star
    public var orbitalPeriod: String
    
    /// A number denoting the gravity of this planet, where "1" is normal or
    /// 1 standard G. "2" is twice or 2 standard Gs. "0.5" is half or 0.5
    /// standard Gs.
    public var gravity: String
    
    /// The average population of sentient beings inhabiting this planet
    public var population: String
    
    /// The climate of this planet. Comma separated if diverse
    public var climate: String
    
    /// The terrain of this planet. Comma separated if diverse
    public var terrain: String
    
    /// The percentage of the planet surface that is naturally occurring water or bodies of water
    public var surfaceWater: String
    
    /// An array of People URL Resources that live on this planet
    // var residents: [People]
    
    /// An array of Film URL Resources that this planet has appeared in
    // var films: [Film]
    
    /// The hypermedia URL of this resource
    public var url: String
    
    /// The ISO 8601 date format of the time that this resource was created
    public var created: String
    
    /// The ISO 8601 date format of the time that this resource was edited
    public var edited: String
}

extension PlanetModel: Identifiable {
    public var id: UUID { UUID() }
}

extension PlanetModel {
    public static func fetch(id: Int) async -> PlanetModel? {
        return await DefaultSWAPIManager.fetch(PlanetsEndpoint.planet(id))
    }
    
    public static func fetch(id: Int, completionHandler: @escaping ((PlanetModel?) -> Void)) {
        Task {
            let data = await fetch(id: id)
            completionHandler(data)
        }
    }
}

extension PlanetModel {
    public static func mock() -> PlanetModel {
        return PlanetModel(name: "Tatooine",
                           diameter: "10465",
                           rotationPeriod: "23",
                           orbitalPeriod: "304",
                           gravity: "1 standard",
                           population: "200000",
                           climate: "arid",
                           terrain: "desert",
                           surfaceWater: "1",
                           url: "https://swapi.dev/api/planets/1/",
                           created: "2014-12-09T13:50:49.641000Z",
                           edited: "2014-12-20T20:58:18.411000Z")
    }
}
