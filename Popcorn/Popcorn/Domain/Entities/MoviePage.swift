//
//  MoviePage.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 6/4/23.
//

import Foundation

struct MoviePage {
    let page: Int?
    let movies: [Movie]
}

extension MoviePage {
    
    var totalPages: Int {
        return 10
    }
    
    var hasMorePages: Bool {
        guard let page = page else { return false }
        return page < totalPages
    }
    
    var nextPage: Int {
        guard let page = page else { return 1 }
        return page + 1
    }
}
