//
//  SearchMovieViewModel.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 5/4/23.
//

import Foundation
import RxSwift

class SearchMovieViewModel {
    public let discoverMoviesViewState: Observable<ViewState<Movie>>
    
    private let fetchDiscoveryMovieUseCase: FetchDiscoverMoviesUseCase
    private let discoverMoviesViewStateSubject: BehaviorSubject<ViewState<Movie>> = BehaviorSubject(value: .loading)
    
    private let disposeBag = DisposeBag()
    
    init(fetchDiscoveryMovieUseCase: FetchDiscoverMoviesUseCase) {
        self.fetchDiscoveryMovieUseCase = fetchDiscoveryMovieUseCase
        
        discoverMoviesViewState = discoverMoviesViewStateSubject.asObservable()
    }
    
    func viewDidLoad() {
        fetchDiscoveryMovieUseCase
            .execute()
            .map { movies -> ViewState<Movie> in
                    .loaded(movies)
            }
            .do(onError: { [weak self] in
                self?.discoverMoviesViewStateSubject.onNext(.error($0.localizedDescription))
            })
            .bind(to: discoverMoviesViewStateSubject)
            .disposed(by: disposeBag)
    }
}
