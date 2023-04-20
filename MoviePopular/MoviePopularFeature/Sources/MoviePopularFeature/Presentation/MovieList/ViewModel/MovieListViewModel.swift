//
//  MovieListViewModel.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 6/4/23.
//

import Foundation
import RxSwift
import Common
import RxCocoa
import MoviePopularInterface

class MovieListViewModel {
    
    let moviesViewState: Observable<ViewState<Movie>>
    let moviesViewStateSubject: BehaviorSubject<ViewState<Movie>> = .init(value: .loading)
    
    private let category: String
    private let fetchMoviesUseCase: FetchMoviesByCategoryUseCase
    private var movies = [Movie]()
    private let coordinator: MainCoordinator
    
    private let disposeBag = DisposeBag()
    
    init(category: String, fetchMoviesUseCase: FetchMoviesByCategoryUseCase, coordinator: MainCoordinator) {
        self.category = category
        self.fetchMoviesUseCase = fetchMoviesUseCase
        self.coordinator = coordinator
        
        moviesViewState = moviesViewStateSubject.asObservable()
    }
    
    deinit {
      print("deinit \(Self.self)")
    }
    
    func viewDidLoad() {
        getMovies(page: 1)
    }
    
    func getMovies(page: Int) {
        if let state = try? moviesViewStateSubject.value(), state.isInitialPage {
            moviesViewStateSubject.onNext(.loading)
        }
        
        let request = FetchMoviesByCategoryUseCaseRequestValue(category: category, page: page)
        
        fetchMoviesUseCase.execute(requestValue: request)
            .map(processFetched)
            .subscribe(onNext: { [weak self] viewState in
                self?.moviesViewStateSubject.onNext(viewState)
            }, onError: { [weak self] error in
                self?.moviesViewStateSubject.onNext(.error(error.localizedDescription))
            })
            .disposed(by: disposeBag)
    }
    
    func reloadData() {
        movies.removeAll()
        moviesViewStateSubject.onNext(.loading)
        getMovies(page: 1)
    }
    
    private func processFetched(for page: MoviePage) -> ViewState<Movie> {
        movies.append(contentsOf: page.movies)
        
        if movies.isEmpty ||
            (page.movies.isEmpty && page.page == 1) {
            return .empty
        }
        
        if page.hasMorePages {
            return .paging(movies, next: page.nextPage)
        } else {
            return .loaded(movies)
        }
    }
    
    func didSelectMovie(_ movieId: Int) {
        coordinator.navigate(to: .movieDetail(movieId))
    }
}
