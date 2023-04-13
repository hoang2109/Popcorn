//
//  FetchVideoTrialersUseCase.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import Foundation
import RxSwift

protocol FetchVideoTrialersUseCase {
    func execute(requestValue: FetchVideoTrialersUseCaseRequestValue) -> Observable<[VideoTrailer]>
}

struct FetchVideoTrialersUseCaseRequestValue {
    let identifier: Int
}

class DefaultFetchVideoTrialersUseCase: FetchVideoTrialersUseCase {
    let videoTrailerRepository: VideoTrailerRepository
    
    init(videoTrailerRepository: VideoTrailerRepository) {
        self.videoTrailerRepository = videoTrailerRepository
    }
    
    func execute(requestValue: FetchVideoTrialersUseCaseRequestValue) -> RxSwift.Observable<[VideoTrailer]> {
        return videoTrailerRepository.fetchVideoTrailers(with: requestValue.identifier)
    }
}
