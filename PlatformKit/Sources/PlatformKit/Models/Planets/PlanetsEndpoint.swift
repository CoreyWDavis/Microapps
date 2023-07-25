//
//  PlanetsEndpoint.swift
//  
//
//  Created by Corey Davis on 7/24/23.
//

import Foundation

// https://swapi.dev/api/planets/       All planets
// https://swapi.dev/api/planets/1/     Specific planet

public enum PlanetsEndpoint: SWAPIEndpointRepresentable {
    private enum RawPath: String {
        case planets = "planets"
        case planetByID = "planets/%d"
    }
    
    case allPlanets
    case planet(_ id: Int)
    
    public func method() throws -> HTTPMethod {
        switch self {
        case .allPlanets, .planet: return .get
        }
    }
    
    public func path() throws -> String {
        switch self {
        case .allPlanets:
            return RawPath.planets.rawValue
        case .planet(let id):
            return String(format: RawPath.planetByID.rawValue, id)
        }
    }
    
    public func queryItems() throws -> [String: String?]? {
        return nil
    }
    
    public func decodingStrategy() -> JSONDecoder.KeyDecodingStrategy {
        return .convertFromSnakeCase
    }
    
    public var description: String {
        switch self {
        case .allPlanets: return "All planets"
        case .planet(let id): return "Planet ID \(id)"
        }
    }
}
