//
//  EndpointFactory.swift
//  Microapps
//
//  Created by Corey Davis on 7/15/23.
//

import Foundation

enum EndpointFactoryError: Error {
    case unableToConstructURLFromComponents(String)
}

struct EndpointFactory {
    static func makeRequest(_ endpoint: EndpointRepresentable) throws -> URLRequest {
        do {
            var request = try URLRequest(url: makeURL(endpoint))
            request.httpMethod = try endpoint.method().rawValue
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
            return request
        } catch {
            throw error
        }
    }
    
    static func makeURL(_ endpoint: EndpointRepresentable) throws -> URL {
        do {
            let urlComponents = try makeURLComponents(endpoint)
            guard let finalURL = urlComponents.url else {
                throw EndpointFactoryError.unableToConstructURLFromComponents(urlComponents.debugDescription)
            }
            return finalURL
        } catch {
            throw error
        }
    }
}

// MARK: - Private Helpers

extension EndpointFactory {
    private static func makeURLComponents(_ endpoint: EndpointRepresentable) throws -> URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "swapi.dev"
        do {
            let path = try endpoint.path()
            components.path = "/api/" + path + "/"
            let items = try makeQueryItems(endpoint)
            if items.count > 0 {
                components.queryItems = items
            }
            return components
        } catch {
            throw error
        }
    }
    
    /// Create URL query items for the specific endpoint.
    /// - Parameter endpoint: The endpoint as an `EndpointRepresentable`
    /// - Returns: An array of `URLQueryItem` objects
    private static func makeQueryItems(_ endpoint: EndpointRepresentable) throws -> [URLQueryItem] {
        var items: [URLQueryItem] = []
        do {
            // Append any query items specific to this endpoint
            try endpoint.queryItems()?.forEach { items.append(URLQueryItem(name: $0.key, value: $0.value)) }
            return items
        } catch {
            throw error
        }
    }
}
