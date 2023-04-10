//
//  HomeViewModel.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 2/4/23.
//

import Foundation
import RxSwift

protocol HomeViewModel {
  
    // MARK: - Input
    func viewDidLoad()
    func refreshMovies()
    func didSelectMovie(_ movieId: Int)
    
    // MARK: - Output
    var isRefreshing: Observable<Bool> { get }
    var moviesSections: Observable<[HomeSectionModel]> { get }
}

class DefaultHomeViewModel: HomeViewModel {
    
    let isRefreshing: Observable<Bool>
    let moviesSections: Observable<[HomeSectionModel]>
    
    private var isRefreshingSubject = BehaviorSubject(value: false)
    private var moviesSectionsSubject = BehaviorSubject<[HomeSectionModel]>(value: [
        .popularMovies([Movie]()),
        .topRatedMovies([Movie]()),
        .upcomingMovies([Movie]()),
        .latestMovies([Movie]())
    ])
    
    private let fetchPopularMoviesUseCase: FetchPopularMoviesUseCase
    private let fetchTopRatedMoviesUseCase: FetchTopRatedMoviesUseCase
    private let fetchUpComingMoviesUseCase: FetchUpComingMoviesUseCase
    private let fetchLatestMoviesUseCase: FetchLatestMoviesUseCase
    private let coordinator: MainCoordinator
    
    private let disposeBag = DisposeBag()
    
    init(fetchPopularMoviesUseCase: FetchPopularMoviesUseCase,
         fetchTopRatedMoviesUseCase: FetchTopRatedMoviesUseCase,
         fetchUpComingMoviesUseCase: FetchUpComingMoviesUseCase,
         fetchLatestMoviesUseCase: FetchLatestMoviesUseCase,
         coordinator: MainCoordinator) {
        self.fetchPopularMoviesUseCase = fetchPopularMoviesUseCase
        self.fetchTopRatedMoviesUseCase = fetchTopRatedMoviesUseCase
        self.fetchUpComingMoviesUseCase = fetchUpComingMoviesUseCase
        self.fetchLatestMoviesUseCase = fetchLatestMoviesUseCase
        self.coordinator = coordinator
        
        isRefreshing = isRefreshingSubject.asObservable()
        moviesSections = moviesSectionsSubject.asObservable()
    }
    
    func viewDidLoad() {
        refreshMovies()
    }
    
    func refreshMovies() {
        isRefreshingSubject.onNext(true)
        let popularMovies = fetchPopularMoviesUseCase.execute()
            .map(HomeSectionModel.popularMovies)
        let topRatedMovies = fetchTopRatedMoviesUseCase.execute()
            .map(HomeSectionModel.topRatedMovies)
        let upcomingMovies = fetchUpComingMoviesUseCase.execute()
            .map(HomeSectionModel.upcomingMovies)
        let latestMovies = fetchLatestMoviesUseCase.execute()
            .map(HomeSectionModel.latestMovies)
        
        Observable.merge([popularMovies, topRatedMovies, upcomingMovies, latestMovies])
            .map { [weak self] section in
                var sections = (try? self?.moviesSectionsSubject.value()) ?? []
                switch section {
                case .popularMovies:
                    sections[0] = section
                case .topRatedMovies:
                    sections[1] = section
                case .upcomingMovies:
                    sections[2] = section
                case .latestMovies:
                    sections[3] = section
                }
                return sections
            }
            .do(onNext: { [weak self] _ in
                self?.isRefreshingSubject.onNext(false)
            })
            .bind(to: moviesSectionsSubject).disposed(by: disposeBag)
    }
    
    func didSelectMovie(_ movieId: Int) {
        coordinator.navigate(to: .movieDetail(movieId))
    }
}


