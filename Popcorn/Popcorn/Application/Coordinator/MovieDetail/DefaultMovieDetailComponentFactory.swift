//
//  DefaultMovieDetailComponentFactory.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 11/4/23.
//

import Foundation
import UIKit
import NetworkingInterface

class DefaultMovieDetailComponentFactory: MovieDetailComponentFactory {
    private let networkService: DataTransferService
    
    private lazy var movieRepository: MovieRepository = {
        return DefaultMovieRepository(networkService: networkService)
    }()
    private lazy var creditRepository: CreditRepository = {
        return DefaultCreditRepository(networkService: networkService)
    }()
    private lazy var videoTrailerRepository: VideoTrailerRepository = {
        return DefaultVideoTrailerRepository(networkService: networkService)
    }()
    private lazy var actorRepository: ActorRepository = {
        return DefaultActorRepository(networkService: networkService)
    }()
    
    init(networkService: DataTransferService) {
        self.networkService = networkService
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
    func createMovieDetailViewController(with movieId: Int, coordinator: MovieDetailCoordinator) -> UIViewController {
        let viewModel = MovieDetailViewModel(movieId: movieId,
                                             fetchMovieDetailUseCase: makeFetchMovieDetailUseCase(),
                                             fetchCreditsUseCase: makeFetchCastsUseCase(),
                                             fetchVideoTrailerUseCase: makeFetchVideoTrialersUseCase(),
                                             coordinator: coordinator)
        let vc = MovieDetailViewController.create(with: viewModel)
        return vc
    }
    
    func createActorDetailViewController(with actorId: Int, coordinator: MovieDetailCoordinator) -> UIViewController {
        let viewModel = ActorDetailViewModel(actorId: actorId,
                                             fetchActorDetailUseCase: makeFetchActorDetailUseCase(),
                                             fetchActorCreditsUseCase: makeFetchActorCreditsUseCase(),
                                             coordinator: coordinator)
        let vc = ActorDetailViewController.create(with: viewModel)
        return vc
    }
    
    private func makeFetchCastsUseCase() -> DefaultFetchCastsUseCase {
        DefaultFetchCastsUseCase(creditRepository: creditRepository)
    }
    
    private func makeFetchVideoTrialersUseCase() -> FetchVideoTrialersUseCase {
        DefaultFetchVideoTrialersUseCase(videoTrailerRepository: videoTrailerRepository)
    }
    
    private func makeFetchMovieDetailUseCase() -> FetchMovieDetailUseCase {
        DefaultFetchMovieDetailUseCase(movieRepository: movieRepository)
    }
    
    private func makeFetchActorDetailUseCase() -> FetchActorDetailUseCase {
        DefaultFetchActorDetailUseCase(actorRepository: actorRepository)
    }
    
    private func makeFetchActorCreditsUseCase() -> FetchActorCreditsUseCase {
        DefaultFetchActorCreditsUseCase(actorRepository: actorRepository)
    }
}
