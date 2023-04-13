//
//  FetchPopularMoviesUseCase.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 2/4/23.
//

import Foundation
import RxSwift

protocol FetchPopularMoviesUseCase {
    func execute() -> Observable<[Movie]>
}

final class DefaultFetchPopularMoviesUseCase: FetchPopularMoviesUseCase {
    
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute() -> Observable<[Movie]> {
        return movieRepository.fetchPopularMovies()
    }
}
