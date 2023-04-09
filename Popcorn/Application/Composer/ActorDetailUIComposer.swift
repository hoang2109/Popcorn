//
//  ActorDetailUIComposer.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 9/4/23.
//

import Foundation

enum ActorDetailUIComposer {
    static func compose(_ actorId: Int, _ networkService: DataTransferService, _ delegate: ActorDetailViewControllerDelegate?) -> ActorDetailViewController {
        let actorRepository = DefaultActorRepository(networkService: networkService)
        let fetchActorDetailUseCase = DefaultFetchActorDetailUseCase(actorRepository: actorRepository)
        let fetchActorCreditsUseCase = DefaultFetchActorCreditsUseCase(actorRepository: actorRepository)
        let viewModel = ActorDetailViewModel(actorId: actorId, fetchActorDetailUseCase: fetchActorDetailUseCase, fetchActorCreditsUseCase: fetchActorCreditsUseCase)
        let vc = ActorDetailViewController.create(with: viewModel, delegate)
        return vc
    }
}
