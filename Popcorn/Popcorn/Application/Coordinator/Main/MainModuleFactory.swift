//
//  MainModuleFactory.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 11/4/23.
//

import Foundation
import UIKit
import Common

protocol MainModuleFactory {
    func createMainCoordinator(navigationController: UINavigationController) -> Coordinator
}
