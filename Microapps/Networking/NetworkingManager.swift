//
//  NetworkingManager.swift
//  Microapps
//
//  Created by Corey Davis on 7/15/23.
//

import Foundation

struct NetworkingManager {    
    static func fetch<T: Codable>(_ endpoint: EndpointRepresentable) async -> T? {
        do {
            let request = try EndpointFactory.makeRequest(endpoint)
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Unexpected resposne: \(response.description)")
                return nil
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Unsuccessful response: \(httpResponse)")
                return nil
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch EndpointFactoryError.unableToConstructURLFromComponents(let description) {
            print("Error building URL: \(description)")
        } catch {
            print("Error fetching data: \(error)")
        }
        return nil
    }
}
