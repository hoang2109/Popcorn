//
//  ActorDetailViewModel.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 8/4/23.
//

import Foundation
import RxSwift

class ActorDetailViewModel {
    
    let viewState: Observable<ViewState<ActorDetail>>
    let credits: Observable<[Movie]>
    
    private let actorId: Int
    private let fetchActorDetailUseCase: FetchActorDetailUseCase
    private let fetchActorCreditsUseCase: FetchActorCreditsUseCase
    private let coordinator: MovieDetailCoordinator
    
    private let viewStateSubject = BehaviorSubject<ViewState<ActorDetail>>(value: .loading)
    private let creditsSubject = BehaviorSubject<[Movie]>(value: [])
    
    private let disposeBag = DisposeBag()
    
    init(actorId: Int, fetchActorDetailUseCase: FetchActorDetailUseCase, fetchActorCreditsUseCase: FetchActorCreditsUseCase, coordinator: MovieDetailCoordinator) {
        self.actorId = actorId
        self.fetchActorDetailUseCase = fetchActorDetailUseCase
        self.fetchActorCreditsUseCase = fetchActorCreditsUseCase
        self.coordinator = coordinator
        
        viewState = viewStateSubject.asObservable()
        credits = creditsSubject.asObservable()
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
    func viewDidLoad() {
        let actorId = self.actorId
        fetchActorDetailUseCase.execute(requestValue: FetchActorDetailUseCaseRequestValue(id: actorId))
            .do(onNext: { [weak self] in
                self?.viewStateSubject.onNext(.loaded([$0]))
            })
            .flatMap { [weak self] _ -> Observable<[Movie]> in
                guard let self = self else {
                    return Observable.just([])
                }
                return fetchActorCreditsUseCase.execute(requestValue: FetchActorCreditsUseCaseRequestValue(id: actorId))
            }
            .subscribe { [weak self] in
                guard let self = self else { return }
                self.creditsSubject.onNext($0)
            }
            .disposed(by: disposeBag)
    }
    
    func didSelectMovie(_ movieId: Int) {
        coordinator.navigate(to: .dismissActorDetail)
        coordinator.navigate(to: .movieDetail(movieId))
    }
}
