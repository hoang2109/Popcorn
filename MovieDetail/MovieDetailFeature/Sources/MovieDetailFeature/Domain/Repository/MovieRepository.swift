//
//  MovieRepository.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 2/4/23.
//

import Foundation
import RxSwift

protocol MovieRepository {
    func fetchMovieDetail(with movieId: Int) -> Observable<MovieDetail>
}
