//
//  FetchActorDetailUseCase.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 8/4/23.
//

import Foundation
import RxSwift

protocol FetchActorDetailUseCase {
    func execute(requestValue: FetchActorDetailUseCaseRequestValue) -> Observable<ActorDetail>
}

struct FetchActorDetailUseCaseRequestValue {
    let id: Int
}

final class DefaultFetchActorDetailUseCase: FetchActorDetailUseCase {
    
    private let actorRepository: ActorRepository
    
    init(actorRepository: ActorRepository) {
        self.actorRepository = actorRepository
    }
    
    func execute(requestValue: FetchActorDetailUseCaseRequestValue) -> Observable<ActorDetail> {
        return actorRepository.fetchActorDetail(requestValue.id)
    }
}
