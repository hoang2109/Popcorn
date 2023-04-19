//
//  CastResponse.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import Foundation

struct CastResultResponse : Codable {
    let cast: [CastResponse]
}

struct CastResponse : Codable {
    let adult: Bool
    let gender: Int?
    let id: Int
    let known_for_department: String
    let name: String
    let original_name: String
    let popularity: Double
    let profile_path: String?
    let cast_id: Int
    let character: String
    let credit_id: String
    let order: Int
}
