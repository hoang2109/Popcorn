//
//  DefaultVideoTrailerRepository.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import Foundation
import RxSwift

class DefaultVideoTrailerRepository: VideoTrailerRepository {
    private let networkService: DataTransferService
    
    init(networkService: DataTransferService) {
        self.networkService = networkService
    }
    
    func fetchVideoTrailers(with movieId: Int) -> RxSwift.Observable<[VideoTrailer]> {
        return networkService.request(MovieEndPoint.getVideoTrailers(movieId), PageResultResponse<VideoTrailerResponse>.self).map {
            $0.results.map {
                VideoTrailer(key: $0.key ?? "")
            }
        }
    }
}
