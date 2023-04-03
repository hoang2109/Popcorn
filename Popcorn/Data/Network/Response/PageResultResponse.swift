//
//  PageResultDTO.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 2/4/23.
//

import Foundation

struct PageResultResponse<T: Codable>: Codable {
    let results: [T]
}
