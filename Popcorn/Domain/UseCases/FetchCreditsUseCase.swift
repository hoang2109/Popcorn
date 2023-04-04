//
//  FetchCastsUseCase.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import Foundation
import RxSwift

protocol FetchCreditsUseCase {
    func execute(requestValue: FetchCreditsUseCaseRequestValue) -> Observable<[Cast]>
}

struct FetchCreditsUseCaseRequestValue {
    let identifier: Int
}

class DefaultFetchCastsUseCase: FetchCreditsUseCase {
    let creditRepository: CreditRepository
    
    init(creditRepository: CreditRepository) {
        self.creditRepository = creditRepository
    }
    
    func execute(requestValue: FetchCreditsUseCaseRequestValue) -> RxSwift.Observable<[Cast]> {
        return creditRepository.fetchCredits(with: requestValue.identifier)
    }
}
