//
//  Coordinator.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 9/4/23.
//

import Foundation
import UIKit

public protocol Step {
}

public struct DefaultStep: Step {
    init() { }
}

public protocol Coordinator {
    func start(with step: Step)
    func start()
}

extension Coordinator {
    func start(with step: Step = DefaultStep() ) { }
    func start() { }
}

public protocol NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController { get }
}
