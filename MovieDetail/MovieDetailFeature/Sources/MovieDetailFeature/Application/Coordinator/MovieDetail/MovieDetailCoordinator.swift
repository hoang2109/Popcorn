//
//  MovieDetailCoordinator.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 11/4/23.
//

import Foundation
import UIKit

public enum MovieDetailStep {
    case movieDetail(Int)
    case actorDetail(Int)
    case dismissActorDetail
    case movieDetailFinish
}

public protocol MovieDetailCoordinator: NavigationCoordinator, AnyObject {
    var onFinish: (() -> Void)? { get }
    
    func navigate(to step: MovieDetailStep)
}


