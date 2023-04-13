//
//  EndPoint+Ext.swift
//  Networking
//
//  Created by Hoang Nguyen on 13/4/23.
//

import Foundation
import NetworkingInterface

extension EndPoint {
    
    func getUrlRequest(with config: NetworkConfiguration) -> URLRequest {
        guard let url = getUrl(with: config) else {
            fatalError("URL could not be built")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        guard let params = queryParameters, method != .get else { return request }
        
        return buildRequest(request, with: params)
    }
    
    private func buildRequest(_ request: URLRequest, with params: [String: Any]) -> URLRequest {
        var postRequest = request
        
        switch parameterEncoding {
        case .defaultEncoding:
            break
            
        case .jsonEncoding:
            postRequest.setJSONContentType()
            let jsonData = try? JSONSerialization.data(withJSONObject: params)
            postRequest.httpBody = jsonData
            
        case .compositeEncoding:
            if let bodyParams = params["body"] as? [String: Any] {
                postRequest.setJSONContentType()
                let jsonData = try? JSONSerialization.data(withJSONObject: bodyParams)
                postRequest.httpBody = jsonData
            }
        }
        return postRequest
    }
    
    private func getUrl(with config: NetworkConfiguration) -> URL? {
        var urlComponents = URLComponents(string: config.baseURL)
        urlComponents?.path = path
        
        var queryItems: [URLQueryItem] = []
        
        // Global query parameters first
        queryItems.append(contentsOf:
                            mapToQueryItems(parameters: config.queryParameters))
        
        // Specifically for each Request
        switch parameterEncoding {
        case .defaultEncoding:
            if method == .get {
                queryItems.append(contentsOf:
                                    mapToQueryItems(parameters: queryParameters) )
            }
        case .compositeEncoding:
            if let params = queryParameters,
               let queryParams = params["query"] as? [String: Any] {
                queryItems.append(contentsOf:
                                    mapToQueryItems(parameters: queryParams))
            }
        default:
            break
        }
        
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
    
    private func mapToQueryItems(parameters: [String: Any]?) -> [URLQueryItem] {
        guard let parameters = parameters else { return [] }
        
        return parameters.map { return URLQueryItem(name: "\($0)", value: "\($1)") }
    }
}
