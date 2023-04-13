//
//  FetchMoviesUseCase.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 6/4/23.
//

import Foundation
import RxSwift

protocol FetchMoviesByCategoryUseCase {
    func execute(requestValue: FetchMoviesByCategoryUseCaseRequestValue) -> Observable<MoviePage>
}

struct FetchMoviesByCategoryUseCaseRequestValue {
    let category: String
    let page: Int
}

final class DefaultFetchMoviesByCategoryUseCase: FetchMoviesByCategoryUseCase {
    
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute(requestValue: FetchMoviesByCategoryUseCaseRequestValue) -> Observable<MoviePage> {
        return movieRepository.fetchMovies(by: requestValue.category, page: requestValue.page)
    }
}
