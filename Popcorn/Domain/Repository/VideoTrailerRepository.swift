//
//  VideoTrailerRepository.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import Foundation
import RxSwift

protocol VideoTrailerRepository {
    func fetchVideoTrailers(with movieId: Int) -> Observable<[VideoTrailer]>
}
