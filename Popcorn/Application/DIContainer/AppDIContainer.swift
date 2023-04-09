//
//  AppDIContainer.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 9/4/23.
//

import Foundation

class AppDIContainer {
    private let appConfiguration: AppConfiguration
    
    init(appConfiguration: AppConfiguration) {
        self.appConfiguration = appConfiguration
    }
    
    lazy var networkService: DataTransferService = {
        let queryParameters = [
            "api_key": appConfiguration.apiKey,
            "language": "en"]
        
        let configuration = DefaultNetworkConfiguration(
            baseURL: appConfiguration.apiBaseURL,
            queryParameters: queryParameters)
        
        return URLSessionHTTPClient(with: configuration)
    }()
}
