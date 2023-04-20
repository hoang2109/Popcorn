//
//  DefaultMovieRepository.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import Foundation
import RxSwift
import NetworkingInterface

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
    
    func fetchDiscoverMovies() -> RxSwift.Observable<[Movie]> {
        return fetchMovies(MovieEndPoint.getDiscoverMovies)
    }
    
    func searchMovies(query: String) -> Observable<[Movie]> {
        return fetchMovies(MovieEndPoint.searchMovie(query))
    }
    
    func fetchMovies(by category: String, page: Int) -> Observable<MoviePage> {
        return networkService.request(MovieEndPoint.getMovies(category, page), PageResultResponse<MovieResponse>.self).map {
            MoviePage(page: $0.page, movies: $0.results.toModels())
        }
    }
    
    private func fetchMovies(_ endPoint: EndPoint) -> Observable<[Movie]> {
        return networkService.request(endPoint, PageResultResponse<MovieResponse>.self).map {
            $0.results.toModels()
        }
    }
    
    func fetchMovieDetail(with movieId: Int) -> RxSwift.Observable<MovieDetail> {
        return networkService.request(MovieEndPoint.getMovieDetail(movieId), MovieDetailResponse.self).map {
            MovieDetail(
                adult: $0.adult,
                backdropPath: $0.backdrop_path,
                genres: $0.genres.map { $0.name },
                id: $0.id,
                originalTitle: $0.original_title,
                overview: $0.overview,
                popularity: $0.popularity,
                posterPath: $0.poster_path,
                releaseDate: $0.release_date,
                title: $0.title,
                voteAverage: $0.vote_average,
                voteCount: $0.vote_count)
        }
    }
}

extension Array where Element == MovieResponse {
    func toModels() -> [Movie] {
        return map {
            Movie(
                id: $0.id,
                overview: $0.overview,
                popularity: $0.popularity,
                posterPath: $0.poster_path,
                releaseDate: $0.release_date,
                title: $0.title,
                voteAverage: $0.vote_average,
                voteCount: $0.vote_count)
        }
    }
}
