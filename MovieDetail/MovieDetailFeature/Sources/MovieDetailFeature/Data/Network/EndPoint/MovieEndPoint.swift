//
//  MovieEndPoint.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import Foundation
import NetworkingInterface

enum MovieEndPoint {
    case getMovieCredits(Int)
    case getVideoTrailers(Int)
    case getMovieDetail(Int)
    case getActorDetail(Int)
    case getActorCredits(Int)
}

extension MovieEndPoint: EndPoint {
    
    var path: String {
        switch self {
        case .getMovieCredits(let movieId):
            return "/3/movie/\(movieId)/credits"
        case .getVideoTrailers(let movieId):
            return "/3/movie/\(movieId)/videos"
        case .getMovieDetail(let movieId):
            return "/3/movie/\(movieId)"
        case .getActorDetail(let id):
            return "/3/person/\(id)"
        case .getActorCredits(let id):
            return "/3/person/\(id)/movie_credits"
        }
    }
    
    var queryParameters: [String: Any]? {
        return [:]
    }
    
    var method: ServiceMethod {
        return .get
    }
    
    var parameterEncoding: ParameterEnconding {
        return .defaultEncoding
    }
}
