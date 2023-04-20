//
//  PageResultDTO.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 2/4/23.
//

import Foundation

struct PageResultResponse<T: Codable>: Codable {
    let page: Int?
    let results: [T]
}
