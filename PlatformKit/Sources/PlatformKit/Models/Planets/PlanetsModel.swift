//
//  PlanetsModel.swift
//  
//
//  Created by Corey Davis on 7/24/23.
//

import Foundation

public struct PlanetsModel: Codable {
    /// The number of starships in the database
    public var count: Int
    
    /// The next page of astarships
    ///
    /// Ex: https://swapi.dev/api/planets/?page=2
    public var next: String?
    
    /// The previous page of starships
    public var previous: String?
    
    /// An array of starships
    public var results: [PlanetModel]
}

extension PlanetsModel {
    public static func fetch() async -> PlanetsModel? {
        return await DefaultSWAPIManager.fetch(PlanetsEndpoint.allPlanets)
    }
    
    public static func fetch(page: Int, completionHandler: @escaping ((PlanetsModel?) -> Void)) {
        Task {
            let data = await fetch()
            completionHandler(data)
        }
    }
}
