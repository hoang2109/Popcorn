//
//  FetchLatestMoviesUseCase.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 2/4/23.
//

import Foundation
import RxSwift

protocol FetchLatestMoviesUseCase {
    func execute() -> Observable<[Movie]>
}

final class DefaultFetchLatestMoviesUseCase: FetchLatestMoviesUseCase {
    
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute() -> Observable<[Movie]> {
        return movieRepository.fetchLatestMovies()
    }
}
