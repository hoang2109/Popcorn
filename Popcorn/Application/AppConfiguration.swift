//
//  AppConfigurations.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import Foundation

struct AppConfiguration {
    
    static var apiKey: String = {
        return "680ebd51dcc601e95626cfd2b274da81"
    }()
    
    static var apiBaseURL: String = {
        return "https://api.themoviedb.org/3"
    }()
    
    static var imagesBaseURL: String = {
        return "https://image.tmdb.org/t/p/w500"
    }()
}
