//
//  MovieEndPoint.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import Foundation
import NetworkingInterface

enum MovieEndPoint {
    case getDiscoverMovies
    case searchMovie(String)
}

extension MovieEndPoint: EndPoint {
    
    var path: String {
        switch self {
        case .getDiscoverMovies:
            return "/3/discover/movie"
        case .searchMovie:
            return "/3/search/movie"
        }
    }
    
    var queryParameters: [String: Any]? {
        var parameters: [String: Any] = [:]
        switch self {
        case .getDiscoverMovies:
            parameters["sort_by"] = "popularity.desc"
            parameters["include_adult"] = false
            parameters["include_video"] = false
            parameters["page"] = 1
            parameters["with_watch_monetization_types"] = "flatrate"
        case .searchMovie(let query):
            parameters["query"] = query
            parameters["page"] = 1
        }
        return parameters
    }
    
    var method: ServiceMethod {
        return .get
    }
    
    var parameterEncoding: ParameterEnconding {
        return .defaultEncoding
    }
}
