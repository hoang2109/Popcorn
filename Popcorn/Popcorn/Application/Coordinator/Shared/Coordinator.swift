//
//  Coordinator.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 9/4/23.
//

import Foundation
import UIKit

protocol Step {
}

struct DefaultStep: Step {
    init() { }
}

protocol Coordinator {
    func start(with step: Step)
    func start()
}

extension Coordinator {
    func start(with step: Step = DefaultStep() ) { }
    func start() { }
}

protocol NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController { get }
}
