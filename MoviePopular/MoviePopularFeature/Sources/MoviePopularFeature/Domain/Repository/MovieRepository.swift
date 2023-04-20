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
    func fetchMovies(by category: String, page: Int) -> Observable<MoviePage>
}
