//
//  PlanetCoordinator.swift
//  
//
//  Created by Corey Davis on 7/24/23.
//

import UIKit
import SwiftUI
import Combine
import CoreKit
import PlatformKit

public class PlanetCoordinator: NavigationCoordinator {
    public var delegate: CoordinatorDelegate?
    public var navigation: UINavigationController
    var subscriptions = Set<AnyCancellable>()
    
    public init(navigationController: UINavigationController) {
        self.navigation = navigationController
    }
    
    public func start() -> UIViewController {
        print("Starting...")
        defer { print("Started") }
        return UIViewController()
    }
    
    public func stop() {
        print("Stopping...")
        defer { print("Stopped") }
    }
}
