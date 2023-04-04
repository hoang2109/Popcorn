//
//  MovieDetailResponse.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import Foundation

struct MovieDetailResponse: Codable {
    let adult: Bool
    let backdrop_path: String?
    let id: Int
    let genres : [GenreResponse]
    let original_title: String
    let overview: String?
    let popularity: Double
    let poster_path: String?
    let release_date: String
    let title: String
    let vote_average: Double
    let vote_count: Int
}
