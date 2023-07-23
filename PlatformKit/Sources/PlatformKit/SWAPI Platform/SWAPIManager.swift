//
//  SWAPIManager.swift
//  Microapps
//
//  Created by Corey Davis on 7/21/23.
//

import Foundation

public typealias SWAPIEndpointRepresentable =
    EndpointRepresentable &
    DecodingRepresentable

protocol SWAPIManager {
    static func fetch<T: Codable>(_ endpoint: SWAPIEndpointRepresentable) async -> T?
}
