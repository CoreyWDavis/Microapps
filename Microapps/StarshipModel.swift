//
//  StarshipModel.swift
//  Microapps
//
//  Created by Corey Davis on 7/15/23.
//

import Foundation

// https://swapi.dev/api/starships/     All ships
// https://swapi.dev/api/starships/9/   Specific ship

struct StarshipModel: Codable {
    /// The common name of this starship
    var name: String
    
    /// The model or official name of this starship
    var model: String
    
    /// The class of this starship
    var starshipClass: String
    
    /// Comma separated string of the startship's manufacturer(s)
    var manufacturer: String
    
    /// The cost of this starship new, in galactic credits
    var costInCredits: String
    
    /// The length of this starship in meters
    var length: String
    
    /// The number of personnel needed to run or pilot this starship
    var crew: String
    
    /// The number of non-essential people this starship can transport
    var passengers: String
    
    /// The maximum speed of this starship in the atmosphere
    ///
    /// "N/A" if this starship is incapable of atmospheric flight
    var maxAtmospheringSpeed: String
    
    /// The class of this starships hyperdrive
    var hyperdriveRating: String
    
    /// The maximum number of kilograms that this starship can transport
    var cargoCapacity: String
    
    /// The maximum length of time that this starship can provide consumables for its entire crew without having to resupply
    var consumables: String
    
    /// An array of Film URL Resources that this starship has appeared in
    // var films: [Film]
    
    /// An array of People URL Resources that this starship has been piloted by
    // var pilots: [Person]
    
    /// The hypermedia URL of this resource
    var url: String
    
    /// The ISO 8601 date format of the time that this resource was created
    var created: String
    
    /// The ISO 8601 date format of the time that this resource was edited
    var edited: String
}

extension StarshipModel {
    static func fetch(id: Int) async -> StarshipModel? {
        return await NetworkingManager.fetch(StarshipEndpoint.starship(id))
    }
        
    static func fetch(id: Int, completionHandler: @escaping ((StarshipModel?) -> Void)) {
        Task {
            let data = await fetch(id: id)
            completionHandler(data)
        }
    }
}

extension StarshipModel {
    static func mock() -> StarshipModel {
        return StarshipModel(name: "Death Star",
                             model: "DS-1 Orbital Battle Station",
                             starshipClass: "Deep Space Mobile Battlestation",
                             manufacturer: "Imperial Department of Military Research, Sienar Fleet Systems",
                             costInCredits: "1000000000000",
                             length: "120000",
                             crew: "342,953",
                             passengers: "843,342",
                             maxAtmospheringSpeed: "n/a",
                             hyperdriveRating: "4.0",
                             cargoCapacity: "1000000000000",
                             consumables: "3 years",
                             url: "https://swapi.dev/api/starships/9/",
                             created: "2014-12-10T16:36:50.509000Z",
                             edited: "2014-12-20T21:26:24.783000Z")
    }
}
