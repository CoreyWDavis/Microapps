//
//  StaeshipEndpoint.swift
//  Microapps
//
//  Created by Corey Davis on 7/15/23.
//

import Foundation

enum StarshipEndpoint: SWAPIEndpointRepresentable {
    private enum StarshipRawPath: String {
        case starships = "starships"
        case starshipByID = "starships/%d"
    }
    
    case allStarships
    case starship(_ id: Int)
    
    func method() throws -> HTTPMethod {
        switch self {
        case .allStarships, .starship: return .get
        }
    }
    
    func path() throws -> String {
        switch self {
        case .allStarships:
            return StarshipRawPath.starships.rawValue
        case .starship(let id):
            return String(format: StarshipRawPath.starshipByID.rawValue, id)
        }
    }
    
    func queryItems() throws -> [String: String?]? {
        return nil
    }
    
    func decodingStrategy() -> JSONDecoder.KeyDecodingStrategy {
        return .convertFromSnakeCase
    }
    
    var description: String {
        switch self {
        case .allStarships: return "All starships"
        case .starship(let id): return "Starship ID \(id)"
        }
    }
}
