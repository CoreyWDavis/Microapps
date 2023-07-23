//
//  Coordinator.swift
//  
//
//  Created by Corey Davis on 7/23/23.
//

import UIKit

public protocol Coordinator: AnyObject {
    var delegate: CoordinatorDelegate? { get set }
    
    func start() -> UIViewController
    func stop()
}
