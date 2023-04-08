//
//  FetchActorCreditsUseCase.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 8/4/23.
//

import Foundation
import RxSwift

protocol FetchActorCreditsUseCase {
    func execute(requestValue: FetchActorCreditsUseCaseRequestValue) -> Observable<[Movie]>
}

struct FetchActorCreditsUseCaseRequestValue {
    let id: Int
}

final class DefaultFetchActorCreditsUseCase: FetchActorCreditsUseCase {
    
    private let actorRepository: ActorRepository
    
    init(actorRepository: ActorRepository) {
        self.actorRepository = actorRepository
    }
    
    func execute(requestValue: FetchActorCreditsUseCaseRequestValue) -> Observable<[Movie]> {
        return actorRepository.fetchActorCredits(requestValue.id)
    }
}
