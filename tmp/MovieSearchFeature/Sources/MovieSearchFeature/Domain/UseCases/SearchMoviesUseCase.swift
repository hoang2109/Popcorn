//
//  SearchMoviesUseCase.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 6/4/23.
//

import Foundation
import RxSwift

protocol SearchMoviesUseCase {
    func execute(requestValue: SearchMoviesUseCaseRequestValue) -> Observable<[Movie]>
}

struct SearchMoviesUseCaseRequestValue {
    let query: String
}

final class DefaultSearchMoviesUseCase: SearchMoviesUseCase {
    
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute(requestValue: SearchMoviesUseCaseRequestValue) -> Observable<[Movie]> {
        return movieRepository.searchMovies(query: requestValue.query)
    }
}
