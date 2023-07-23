//
//  EndpointRepresentable.swift
//  Microapps
//
//  Created by Corey Davis on 7/15/23.
//

import Foundation

public protocol HTTPMethodRepresentable {
    func method() throws -> HTTPMethod
}

public protocol PathRepresentable {
    func path() throws -> String
    func queryItems() throws -> [String: String?]?
}

public protocol DecodingRepresentable {
    func decodingStrategy() -> JSONDecoder.KeyDecodingStrategy
}

public typealias EndpointRepresentable =
    HTTPMethodRepresentable &
    PathRepresentable
