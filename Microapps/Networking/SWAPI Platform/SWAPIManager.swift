//
//  SWAPIManager.swift
//  Microapps
//
//  Created by Corey Davis on 7/21/23.
//

import Foundation

protocol SWAPIEndpointRepresentable: EndpointRepresentable {}

protocol SWAPIManager {
    static func fetch<T: Codable>(_ endpoint: EndpointRepresentable) async -> T?
}
