//
//  MovieDetailViewModel.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import Foundation
import RxSwift

final class MovieDetailViewModel {
    
    // MARK: - Public Api
    public let movieInfoViewState: Observable<ViewState<MovieDetailInfo>>
    public let creditsViewState: Observable<ViewState<Cast>>
    public let videosViewState: Observable<ViewState<VideoTrailer>>
    
    // MARK: - Private
    private let movieId: Int
    private let fetchMovieDetailUseCase: FetchMovieDetailUseCase
    private let fetchCreditsUseCase: FetchCreditsUseCase
    private let fetchVideoTrailerUseCase: FetchVideoTrialersUseCase
    
    private var movieInfoViewStateSubject = BehaviorSubject<ViewState<MovieDetailInfo>>(value: .loading)
    private var creditsViewStateSubject = BehaviorSubject<ViewState<Cast>>(value: .loading)
    private var videosViewStateSubject = BehaviorSubject<ViewState<VideoTrailer>>(value: .loading)
    private var coordinator: MainCoordinator
    
    private var disposeBag = DisposeBag()
    
    init(movieId: Int, fetchMovieDetailUseCase: FetchMovieDetailUseCase, fetchCreditsUseCase: FetchCreditsUseCase, fetchVideoTrailerUseCase: FetchVideoTrialersUseCase, coordinator: MainCoordinator) {
        self.movieId = movieId
        self.fetchMovieDetailUseCase = fetchMovieDetailUseCase
        self.fetchCreditsUseCase = fetchCreditsUseCase
        self.fetchVideoTrailerUseCase = fetchVideoTrailerUseCase
        self.coordinator = coordinator
        
        movieInfoViewState = movieInfoViewStateSubject.asObservable()
        creditsViewState = creditsViewStateSubject.asObservable()
        videosViewState = videosViewStateSubject.asObservable()
    }
    
    deinit {
      print("deinit \(Self.self)")
    }
    
    func viewDidLoad() {
        let multipleRequests = Observable.zip(fetchMovieDetailUseCase.execute(requestValue: FetchMovieDetailUseCaseRequestValue(identifier: movieId)),
                                              fetchCreditsUseCase.execute(requestValue: FetchCreditsUseCaseRequestValue(identifier: movieId)),
                                              fetchVideoTrailerUseCase.execute(requestValue: FetchVideoTrialersUseCaseRequestValue(identifier: movieId)))
        let responses = multipleRequests.share()
        
        responses.flatMap { [weak self] (movieDetail, _, _) -> Observable<ViewState<MovieDetailInfo>> in
            guard let _ = self else { return Observable.error(CustomError.genericError) }
            return Observable.just(.loaded([MovieDetailInfo(id: movieDetail.id,
                                                            title: movieDetail.title,
                                                            score: String(format:"%.1f", movieDetail.voteAverage) + " (\(String(movieDetail.voteCount)))",
                                                            dateAndGenre: "\(movieDetail.releaseDate.dropLast(6))" + " | " + movieDetail.genres.joined(separator: ", "),
                                                            overview: movieDetail.overview,
                                                            posterPath: movieDetail.posterPath)]))}
        .do(onError: { [weak self] error in
            self?.movieInfoViewStateSubject.onNext( .error(error.localizedDescription) )
        })
        .bind(to: movieInfoViewStateSubject)
        .disposed(by: disposeBag)
                
        responses.flatMap { [weak self] (_, casts, _) -> Observable<ViewState<Cast>> in
            guard let _ = self else { return Observable.error(CustomError.genericError) }
            return Observable.just(.loaded(casts))
        }
        .do(onError: { [weak self] error in
            self?.creditsViewStateSubject.onNext( .error(error.localizedDescription) )
        })
        .bind(to: creditsViewStateSubject)
        .disposed(by: disposeBag)
                    
        responses.flatMap { [weak self] (_, _, videos) -> Observable<ViewState<VideoTrailer>> in
            guard let _ = self else { return Observable.error(CustomError.genericError) }
            return Observable.just(.loaded(videos))
        }
        .do(onError: { [weak self] error in
            self?.videosViewStateSubject.onNext( .error(error.localizedDescription) )
        })
        .bind(to: videosViewStateSubject)
        .disposed(by: disposeBag)
    }
    
    func didSelectActor(_ actorId: Int) {
        coordinator.navigate(to: .actorDetail(actorId))
    }
}

enum CustomError: Error {
    case genericError
}
