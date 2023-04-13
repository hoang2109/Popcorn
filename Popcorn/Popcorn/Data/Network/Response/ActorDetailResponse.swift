//
//  ActorDetail.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 8/4/23.
//

import Foundation

struct ActorDetailResponse: Codable {
    let id: Int
    let name: String
    let biography: String
    let profile_path: String?
}
