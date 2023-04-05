//
//  MovieEndPoint.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import Foundation

enum MovieEndPoint {
    case getPopularMovies(Int)
    case getTopRatedMovies(Int)
    case getUpComingMovies(Int)
    case getNowPlayingMovies(Int)
    case getMovieCredits(Int)
    case getVideoTrailers(Int)
    case getMovieDetail(Int)
    case getDiscoverMovies
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
        case .getMovieCredits(let movieId):
            return "/3/movie/\(movieId)/credits"
        case .getVideoTrailers(let movieId):
            return "/3/movie/\(movieId)/videos"
        case .getMovieDetail(let movieId):
            return "/3/movie/\(movieId)"
        case .getDiscoverMovies:
            return "/3/discover/movie"
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
        case .getDiscoverMovies:
            parameters["sort_by"] = "popularity"
            parameters["include_adult"] = false
            parameters["include_video"] = false
            parameters["page"] = 1
            parameters["with_watch_monetization_types"] = "flatrate"
        default:
            break
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
