//
//  CoordinatorDelegate.swift
//  
//
//  Created by Corey Davis on 7/23/23.
//

import Foundation

public protocol CoordinatorDelegate: AnyObject {
    func coordinatorDidStart(_ coordinator: Coordinator)
    func coordinatorDidStop(_ coordinator: Coordinator)
}
