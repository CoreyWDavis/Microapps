//
//  EndpointRepresentable.swift
//  Microapps
//
//  Created by Corey Davis on 7/15/23.
//

import Foundation

protocol HTTPMethodRepresentable {
    func method() throws -> HTTPMethod
}

protocol PathRepresentable {
    func path() throws -> String
    func queryItems() throws -> [String: String?]?
}

protocol DecodingRepresentable {
    func decodingStrategy() -> JSONDecoder.KeyDecodingStrategy
}

typealias EndpointRepresentable =
    HTTPMethodRepresentable &
    PathRepresentable
