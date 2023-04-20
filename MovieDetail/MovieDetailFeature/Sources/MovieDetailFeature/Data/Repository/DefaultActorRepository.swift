//
//  DefaultActorRepository.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 8/4/23.
//

import Foundation
import RxSwift
import NetworkingInterface

class DefaultActorRepository: ActorRepository {
    private let networkService: DataTransferService
    
    init(networkService: DataTransferService) {
        self.networkService = networkService
    }
    
    func fetchActorDetail(_ actorId: Int) -> Observable<ActorDetail> {
        let endPoint = MovieEndPoint.getActorDetail(actorId)
        return networkService.request(endPoint, ActorDetailResponse.self).map {
            ActorDetail(id: $0.id, name: $0.name, bio: $0.biography, profilePath: $0.profile_path)
        }
    }
    
    func fetchActorCredits(_ actorId: Int) -> Observable<[Movie]> {
        let endPoind = MovieEndPoint.getActorCredits(actorId)
        return networkService.request(endPoind, ActorCreditsResponse.self).map {
            $0.cast.toModels()
        }
    }
}
