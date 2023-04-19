//
//  ViewState.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import Foundation

public enum ViewState<Entity> {
    
    case loading
    case paging([Entity], next: Int)
    case loaded([Entity])
    case empty
    case error(String)
    
    public var currentEntities: [Entity] {
        switch self {
        case .loaded(let entities):
            return entities
        case .paging(let entities, next: _):
            return entities
        case .loading, .empty, .error:
            return []
        }
    }
    
    public var currentPage: Int {
        switch self {
        case .loading, .loaded, .empty, .error:
            return 1
        case .paging(_, next: let page):
            return page
        }
    }
    
    public var isInitialPage: Bool {
        return currentPage == 1
    }
}
