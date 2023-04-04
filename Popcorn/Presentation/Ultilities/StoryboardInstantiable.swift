//
//  StoryboardInstantiable.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import UIKit

public protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype ViewControllerType
    static var defaultFileName: String { get }
    static func instantiateViewController(_ bundle: Bundle?) -> ViewControllerType
}

public extension StoryboardInstantiable where Self: UIViewController {
    
    static var defaultFileName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
    
    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = defaultFileName
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        guard let viewController = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(fileName)")
        }
        return viewController
    }
    
    static func instantiateViewController(fromStoryBoard storyBoard: String, _ bundle: Bundle? = nil) -> Self {
        let identifier = defaultFileName
        let storyboard = UIStoryboard(name: storyBoard, bundle: bundle)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? Self else {
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(identifier)")
        }
        return viewController
    }
}
