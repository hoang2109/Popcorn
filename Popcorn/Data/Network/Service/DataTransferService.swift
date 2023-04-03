//
//  HTTPClient.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 2/4/23.
//

import Foundation
import RxSwift

public protocol DataTransferService {
    func request<Element: Decodable>(_ router: EndPoint, _ type: Element.Type) -> Observable<Element>
}
