//
//  NetworkingManager.swift
//  Microapps
//
//  Created by Corey Davis on 7/15/23.
//

import Foundation

protocol NetworkingManager {
    static func fetch(_ request: URLRequest) async -> Data?
}
