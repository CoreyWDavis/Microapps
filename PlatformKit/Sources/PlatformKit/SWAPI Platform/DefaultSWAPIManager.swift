//
//  DefaultSWAPIManager.swift
//  Microapps
//
//  Created by Corey Davis on 7/21/23.
//

import Foundation

public struct DefaultSWAPIManager: SWAPIManager {
    public static func fetch<T: Codable>(_ endpoint: SWAPIEndpointRepresentable) async -> T? {
        do {
            let request = try EndpointFactory.makeRequest(endpoint)
            guard let data = await DefaultNetworkingManager.fetch(request) else { return nil }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = endpoint.decodingStrategy()
            return try decoder.decode(T.self, from: data)
        } catch EndpointFactoryError.unableToConstructURLFromComponents(let description) {
            print("Error building URL: \(description)")
        } catch {
            print("Error fetching SWAPI endpoint: \(error.localizedDescription)")
        }
        return nil
    }
}
