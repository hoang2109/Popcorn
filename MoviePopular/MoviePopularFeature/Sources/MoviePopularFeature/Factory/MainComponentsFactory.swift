//
//  HomeComponentsFactory.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 10/4/23.
//

import Foundation
import UIKit
import MoviePopularInterface

public protocol MainComponentsFactory {
    func createHomeViewController(coordinator: MainCoordinator) -> UIViewController
    func createMovieListViewController(with cateId: String, coordinator: MainCoordinator) -> UIViewController
}
