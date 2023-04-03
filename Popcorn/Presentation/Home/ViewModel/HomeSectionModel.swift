//
//  HomeSectionModel.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 2/4/23.
//

import Foundation
import RxDataSources

enum MovieTypes: String, CaseIterable, Hashable {
    case popularMovies  = "Popular Movies"
    case topRatedMovies = "Top Rated Movies"
    case upcomingMovies = "Upcoming Movies"
    case latestMovies   = "Latest Movies"
}

enum HomeSectionModel {
    case popularMovies(_ movies: [Movie])
    case topRatedMovies(_ movies: [Movie])
    case upcomingMovies(_ movies: [Movie])
    case latestMovies(_ movies: [Movie])
}

extension HomeSectionModel: SectionModelType {
    typealias Item = Movie
    
    var items: [Item] {
        switch  self {
        case let .popularMovies(movies):
            return movies
        case let .topRatedMovies(movies):
            return movies
        case let .upcomingMovies(movies):
            return movies
        case let .latestMovies(movies):
            return movies
        }
    }
    
    init(original: HomeSectionModel, items: [Item]) {
        self = original
    }
}

extension HomeSectionModel {
    var title: String {
        switch self {
        case .popularMovies:
            return "Popular Movies"
        case .topRatedMovies:
            return "Top Rated Movies"
        case .upcomingMovies:
            return "Upcoming Movies"
        case .latestMovies:
            return "Latest Movies"
        }
    }
}
