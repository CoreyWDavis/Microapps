//
//  StarshipsModel.swift
//  Microapps
//
//  Created by Corey Davis on 7/16/23.
//

import Foundation

struct StarshipsModel: Codable {
    /// The number of starships in the database
    var count: Int
    
    /// The next page of astarships
    ///
    /// Ex: https://swapi.dev/api/starships/?page=2
    var next: String?
        
    /// The previous page of starships
    var previous: String?
    
    /// An array of starships
    var results: [StarshipModel]
}

extension StarshipsModel {
    static func fetch() async -> StarshipsModel? {
        return await DefaultSWAPIManager.fetch(StarshipEndpoint.allStarships)
    }
    
    static func fetch(page: Int, completionHandler: @escaping ((StarshipsModel?) -> Void)) {
        Task {
            let data = await fetch()
            completionHandler(data)
        }
    }
}
