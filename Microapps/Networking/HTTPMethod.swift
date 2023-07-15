//
//  HTTPMethod.swift
//  Microapps
//
//  Created by Corey Davis on 7/15/23.
//

import Foundation

enum HTTPMethod: String { case delete, get, post, put }

extension HTTPMethod: CustomStringConvertible {
    var description: String { return rawValue.uppercased() }
}
