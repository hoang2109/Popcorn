//
//  HomeSectionModel.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 2/4/23.
//

import Foundation
import RxDataSources

enum MovieTypes {
    case popularMovies(key: String, title: String)
    case topRatedMovies(key: String, title: String)
    case upcomingMovies(key: String, title: String)
    case latestMovies(key: String, title: String)
    
    var key: String {
        switch self {
        case let .popularMovies(key: key, title: _):
            return key
        case let .topRatedMovies(key: key, title: _):
            return key
        case let .upcomingMovies(key: key, title: _):
            return key
        case let .latestMovies(key: key, title: _):
            return key
        }
    }
    
    var title: String {
        switch self {
        case let .popularMovies(key: _, title: title):
            return title
        case let .topRatedMovies(key: _, title: title):
            return title
        case let .upcomingMovies(key: _, title: title):
            return title
        case let .latestMovies(key: _, title: title):
            return title
        }
    }
}

enum HomeSectionModel {
    case popularMovies(_ key: String, _ title: String, _ movies: [Movie])
    case topRatedMovies(_ key: String, _ title: String, _ movies: [Movie])
    case upcomingMovies(_ key: String, _ title: String, _ movies: [Movie])
    case latestMovies(_ key: String, _ title: String, _ movies: [Movie])
}

extension HomeSectionModel: SectionModelType {
    typealias Item = Movie
    
    var items: [Item] {
        switch  self {
        case let .popularMovies(_, _, movies):
            return movies
        case let .topRatedMovies(_, _, movies):
            return movies
        case let .upcomingMovies(_, _, movies):
            return movies
        case let .latestMovies(_, _, movies):
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
        case let .popularMovies(_, title, _):
            return title
        case let .topRatedMovies(_, title, _):
            return title
        case let .upcomingMovies(_, title, _):
            return title
        case let .latestMovies(_, title, _):
            return title
        }
    }
    
    var key: String {
        switch self {
        case let .popularMovies(key, _, _):
            return key
        case let .topRatedMovies(key, _, _):
            return key
        case let .upcomingMovies(key, _, _):
            return key
        case let .latestMovies(key, _, _):
            return key
        }
    }
}
