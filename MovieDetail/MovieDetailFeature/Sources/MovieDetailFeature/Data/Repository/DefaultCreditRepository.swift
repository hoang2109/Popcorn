//
//  DefaultCastRepository.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import Foundation
import RxSwift
import NetworkingInterface

class DefaultCreditRepository: CreditRepository {
    private let networkService: DataTransferService
    
    init(networkService: DataTransferService) {
        self.networkService = networkService
    }
    
    func fetchCredits(with movieId: Int) -> RxSwift.Observable<[Cast]> {
        return networkService.request(MovieEndPoint.getMovieCredits(movieId), CastResultResponse.self).map {
            $0.cast.map {
                Cast(adult: $0.adult,
                     gender: $0.gender,
                     id: $0.id,
                     knownForDepartment: $0.known_for_department,
                     name: $0.name,
                     originalName: $0.original_name,
                     popularity: $0.popularity,
                     profilePath: $0.profile_path,
                     castId: $0.cast_id,
                     character: $0.character,
                     creditId: $0.credit_id,
                     order: $0.order)
            }
        }
    }
}
