//
//  EndPoint.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 2/4/23.
//

import Foundation

public protocol EndPoint {
    
    var path: String { get }
    
    var method: ServiceMethod { get }
    
    var queryParameters: [String: Any]? { get }
    
    var parameterEncoding: ParameterEnconding { get }
}

public enum ServiceMethod: String {
    case get = "GET"
    case post = "POST"
}

public enum ParameterEnconding {
    case defaultEncoding
    case jsonEncoding
    case compositeEncoding
}
