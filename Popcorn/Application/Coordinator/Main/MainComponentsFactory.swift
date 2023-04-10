//
//  HomeComponentsFactory.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 10/4/23.
//

import Foundation
import UIKit

protocol MainComponentsFactory {
    func createHomeViewController(coordinator: MainCoordinator) -> UIViewController
    func createMovieListViewController(with cateId: String, coordinator: MainCoordinator) -> UIViewController
    func createMovieDetailViewController(with movieId: Int, coordinator: MainCoordinator) -> UIViewController
    func createActorDetailViewController(with actorId: Int, coordinator: MainCoordinator) -> UIViewController
}
