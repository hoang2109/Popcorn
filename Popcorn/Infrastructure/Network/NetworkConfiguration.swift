//
//  NetworkConfigurable.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import Foundation

public protocol NetworkConfiguration {
    
    var baseURL: String { get }
    
    var headers: [String: String] { get }
    
    var queryParameters: [String: String] { get }
}

public struct DefaultNetworkConfiguration: NetworkConfiguration {
    
    public let baseURL: String
    
    public let headers: [String: String]
    
    public let queryParameters: [String: String]
    
    public init(baseURL: String,
                headers: [String: String] = [:],
                queryParameters: [String: String] = [:]) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
    }
}
