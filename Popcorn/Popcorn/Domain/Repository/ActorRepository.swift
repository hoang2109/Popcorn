//
//  ActorRepository.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 8/4/23.
//

import Foundation
import RxSwift

protocol ActorRepository {
    func fetchActorDetail(_ actorId: Int) -> Observable<ActorDetail>
    func fetchActorCredits(_ actorId: Int) -> Observable<[Movie]>
}
