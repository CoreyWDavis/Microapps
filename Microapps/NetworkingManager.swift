//
//  NetworkingManager.swift
//  Microapps
//
//  Created by Corey Davis on 7/15/23.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

struct NetworkingManager {    
    static func fetch<T: Codable>(method: HTTPMethod, destination: String) async -> T? {
        guard let url = URL(string: destination) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        do {
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
        } catch {
            print("Error fetching data: \(error)")
            return nil
        }
    }
}
