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
    case movieDetail(Int)
    case actorDetail(Int)
    case dismiss
}

protocol MainCoordinator: NavigationCoordinator {
    func navigate(to step: MainStep)
}
