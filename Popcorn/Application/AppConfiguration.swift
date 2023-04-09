//
//  AppConfigurations.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import Foundation

protocol AppConfiguration {
    var apiKey: String { get }
    var apiBaseURL: String { get }
    var imagesBaseURL: String { get }
}

class DefaultAppConfiguration: AppConfiguration {
    
    var apiKey: String = {
        return "680ebd51dcc601e95626cfd2b274da81"
    }()
    
    var apiBaseURL: String = {
        return "https://api.themoviedb.org/3"
    }()
    
    var imagesBaseURL: String = {
        return "https://image.tmdb.org/t/p/w500"
    }()
}
