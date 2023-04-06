//
//  MovieRepository.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 2/4/23.
//

import Foundation
import RxSwift

protocol MovieRepository {
    func fetchPopularMovies() -> Observable<[Movie]>
    func fetchTopRatedMovies() -> Observable<[Movie]>
    func fetchUpComingMovies() -> Observable<[Movie]>
    func fetchLatestMovies() -> Observable<[Movie]>
    func fetchDiscoverMovies() -> Observable<[Movie]>
    func fetchMovieDetail(with movieId: Int) -> Observable<MovieDetail>
    func searchMovies(query: String) -> Observable<[Movie]>
}
