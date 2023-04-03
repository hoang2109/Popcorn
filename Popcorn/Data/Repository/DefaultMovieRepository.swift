//
//  DefaultMovieRepository.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import Foundation
import RxSwift

class DefaultMovieRepository: MovieRepository {
    
    private let networkService: DataTransferService
    
    init(networkService: DataTransferService) {
        self.networkService = networkService
    }
    
    func fetchPopularMovies() -> Observable<[Movie]> {
        return fetchMovies(MovieEndPoint.getPopularMovies(1))
    }
    
    func fetchTopRatedMovies() -> Observable<[Movie]> {
        return fetchMovies(MovieEndPoint.getTopRatedMovies(1))
    }
    
    func fetchUpComingMovies() -> Observable<[Movie]> {
        return fetchMovies(MovieEndPoint.getUpComingMovies(1))
    }
    
    func fetchLatestMovies() -> Observable<[Movie]> {
        return fetchMovies(MovieEndPoint.getNowPlayingMovies(1))
    }
    
    private func fetchMovies(_ endPoint: EndPoint) -> Observable<[Movie]> {
        return networkService.request(endPoint, PageResultResponse<MovieResponse>.self).map {
            $0.results.toModels()
        }
    }
}

extension Array where Element == MovieResponse {
    func toModels() -> [Movie] {
        return map {
            Movie(
                adult: $0.adult ?? false,
                backdropPath: $0.backdrop_path ?? "",
                genreIDS: $0.genre_ids ?? [],
                id: $0.id ?? 0,
                originalTitle: $0.original_title ?? "",
                overview: $0.overview ?? "",
                popularity: $0.popularity ?? 0,
                posterPath: $0.poster_path ?? "",
                releaseDate: $0.release_date ?? "",
                title: $0.title ?? "",
                video: $0.video ?? false,
                voteAverage: $0.vote_average ?? 0,
                voteCount: $0.vote_count ?? 0)
        }
    }
}
