//
//  HomeCoordinator.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 9/4/23.
//

import Foundation

// MARK: - Steps
public enum MainStep: Step {
    case home
    case movieCategory(String, String)
    case movieDetail(Int)
}

protocol MainCoordinator: NavigationCoordinator {
    func navigate(to step: MainStep)
}
