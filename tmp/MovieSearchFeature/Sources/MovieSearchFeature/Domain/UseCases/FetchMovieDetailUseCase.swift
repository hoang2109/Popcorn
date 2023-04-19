//
//  FetchMovieDetailUseCase.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import Foundation
import RxSwift

protocol FetchMovieDetailUseCase {
    func execute(requestValue: FetchMovieDetailUseCaseRequestValue) -> Observable<MovieDetail>
}

struct FetchMovieDetailUseCaseRequestValue {
    let identifier: Int
}

class DefaultFetchMovieDetailUseCase: FetchMovieDetailUseCase {
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute(requestValue: FetchMovieDetailUseCaseRequestValue) -> RxSwift.Observable<MovieDetail> {
        return movieRepository.fetchMovieDetail(with: requestValue.identifier)
    }
}
