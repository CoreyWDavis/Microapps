//
//  StarshipsModel.swift
//  Microapps
//
//  Created by Corey Davis on 7/16/23.
//

import Foundation

public struct StarshipsModel: Codable {
    /// The number of starships in the database
    public var count: Int
    
    /// The next page of astarships
    ///
    /// Ex: https://swapi.dev/api/starships/?page=2
    public var next: String?
        
    /// The previous page of starships
    public var previous: String?
    
    /// An array of starships
    public var results: [StarshipModel]
}

extension StarshipsModel {
    public static func fetch() async -> StarshipsModel? {
        return await DefaultSWAPIManager.fetch(StarshipEndpoint.allStarships)
    }
    
    public static func fetch(page: Int, completionHandler: @escaping ((StarshipsModel?) -> Void)) {
        Task {
            let data = await fetch()
            completionHandler(data)
        }
    }
}
