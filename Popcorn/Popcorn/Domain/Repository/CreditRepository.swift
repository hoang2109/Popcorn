//
//  CastRepository.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import Foundation
import RxSwift

protocol CreditRepository {
    func fetchCredits(with movieId: Int) -> Observable<[Cast]>
}
