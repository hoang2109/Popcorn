//
//  MovieEndPoint.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import Foundation
import NetworkingInterface

enum MovieEndPoint {
    case getPopularMovies(Int)
    case getTopRatedMovies(Int)
    case getUpComingMovies(Int)
    case getNowPlayingMovies(Int)
    case getMovies(String, Int)
}

extension MovieEndPoint: EndPoint {
    
    var path: String {
        switch self {
        case .getPopularMovies:
            return "/3/movie/popular"
        case .getTopRatedMovies:
            return "/3/movie/top_rated"
        case .getUpComingMovies:
            return "/3/movie/upcoming"
        case .getNowPlayingMovies:
            return "/3/movie/now_playing"
        case .getMovies(let category, _):
            return "/3/movie/\(category)"
        }
    }
    
    var queryParameters: [String: Any]? {
        var parameters: [String: Any] = [:]
        
        switch self {
        case .getPopularMovies(let page):
            parameters["page"] = page
        case .getTopRatedMovies(let page):
            parameters["page"] = page
        case .getUpComingMovies(let page):
            parameters["page"] = page
        case .getNowPlayingMovies(let page):
            parameters["page"] = page
        case .getMovies( _, let page):
            parameters["page"] = page
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
