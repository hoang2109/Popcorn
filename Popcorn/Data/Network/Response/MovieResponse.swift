//
//  MovieDTO.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 2/4/23.
//

import Foundation

struct MovieResponse: Codable {
    let adult: Bool
    let backdrop_path: String?
    let id: Int
    let genre_ids : [Int]
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String?
    let release_date: String?
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}
