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
    
    func fetchDiscoverMovies() -> RxSwift.Observable<[Movie]> {
        return fetchMovies(MovieEndPoint.getDiscoverMovies)
    }
    
    func searchMovies(query: String) -> Observable<[Movie]> {
        return fetchMovies(MovieEndPoint.searchMovie(query))
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
