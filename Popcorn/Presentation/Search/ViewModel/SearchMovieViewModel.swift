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
    public let searchResultViewState: Observable<ViewState<Movie>>
    
    private let fetchDiscoveryMovieUseCase: FetchDiscoverMoviesUseCase
    private let searchMoviesUseCase: SearchMoviesUseCase
    private let discoverMoviesViewStateSubject: BehaviorSubject<ViewState<Movie>> = BehaviorSubject(value: .loading)
    private let searchResultViewStateSubject: BehaviorSubject<ViewState<Movie>> = .init(value: .loaded([]))
    
    private let disposeBag = DisposeBag()
    
    init(fetchDiscoveryMovieUseCase: FetchDiscoverMoviesUseCase, searchMoviesUseCase: SearchMoviesUseCase) {
        self.fetchDiscoveryMovieUseCase = fetchDiscoveryMovieUseCase
        self.searchMoviesUseCase = searchMoviesUseCase
        
        discoverMoviesViewState = discoverMoviesViewStateSubject.asObservable()
        searchResultViewState = searchResultViewStateSubject.asObservable()
    }
    
    deinit {
      print("deinit \(Self.self)")
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
    
    func searchMovie(query: String) {
        if (query.count == 0) {
            searchResultViewStateSubject.onNext(.loaded([]))
            return
        }
        
        searchMoviesUseCase.execute(requestValue: SearchMoviesUseCaseRequestValue(query: query))
            .map { movies -> ViewState<Movie> in
                .loaded(movies)
            }
            .subscribe(onNext: { [weak self] viewState in
                self?.searchResultViewStateSubject.onNext(viewState)
            }, onError: { [weak self] error in
                self?.searchResultViewStateSubject.onNext(.error(error.localizedDescription))
            })
            .disposed(by: disposeBag)
    }
    
    func clearSearchResult() {
        searchResultViewStateSubject.onNext(.loaded([]))
    }
}
