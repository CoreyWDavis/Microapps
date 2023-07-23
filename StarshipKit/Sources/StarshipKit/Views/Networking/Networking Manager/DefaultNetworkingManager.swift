//
//  DefaultNetworkingManager.swift
//  Microapps
//
//  Created by Corey Davis on 7/21/23.
//

import Foundation

struct DefaultNetworkingManager: NetworkingManager {
    static func fetch(_ request: URLRequest) async -> Data? {
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
            return data
        } catch {
            print("Error fetching data: \(error)")
        }
        return nil
    }
}
