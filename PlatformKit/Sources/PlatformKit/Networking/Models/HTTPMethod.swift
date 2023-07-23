//
//  HTTPMethod.swift
//  Microapps
//
//  Created by Corey Davis on 7/15/23.
//

import Foundation

public enum HTTPMethod: String { case delete, get, post, put }

extension HTTPMethod: CustomStringConvertible {
    public var description: String { return rawValue.uppercased() }
}
