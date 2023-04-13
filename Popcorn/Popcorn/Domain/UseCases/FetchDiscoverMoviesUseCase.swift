//
//  FetchDiscoverMoviesUseCase.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 5/4/23.
//

import Foundation
import RxSwift

protocol FetchDiscoverMoviesUseCase {
    func execute() -> Observable<[Movie]>
}

final class DefaultFetchDiscoverMoviesUseCase: FetchDiscoverMoviesUseCase {
    
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute() -> Observable<[Movie]> {
        return movieRepository.fetchDiscoverMovies()
    }
}
