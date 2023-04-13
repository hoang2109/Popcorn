//
//  AppDIContainer.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 9/4/23.
//

import Foundation
import NetworkingInterface
import Networking

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
    
    func createMainModuleFactory() -> MainModuleFactory {
        let mainComponentsFactory = DefaultMainComponentsFactory(networkService: networkService)
        let movieDetailFactory = createMovieDetailModuleFactory()
        let factory = DefaultMainModuleFactory(mainComponentsFactory: mainComponentsFactory, movieDetailModuleFactory: movieDetailFactory)
        return factory
    }
    
    func createMovieDetailModuleFactory() -> MovieDetailModuleFactory {
        let movieDetailComponentFactory = DefaultMovieDetailComponentFactory(networkService: networkService)
        let factory = DefaultMovieDetailModuleFactory(movieDetailComponentFactory: movieDetailComponentFactory)
        return factory
    }
    
    func createSearchModuleFactory() -> SearchModuleFactory {
        let movieComponentsFactory = DefaultSearchMovieComponentsFactory(networkService: networkService)
        let factory = DefaultSearchModuleFactory(searchMovieComponentsFactory: movieComponentsFactory, movieDetailModuleFactory: createMovieDetailModuleFactory())
        return factory
    }
}
