//
//  UIImageView+Ext.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 2/4/23.
//

import Foundation
import UIKit
import AlamofireImage

extension UIImageView {
    public func imageFromUrl(urlString: String?, placeHolderImage: UIImage?) {
        
        image = placeHolderImage
    
        if var urlString = urlString {
            if !urlString.hasPrefix("http") {
                urlString = "https://image.tmdb.org/t/p/w500" + urlString
            }
            
            if let url = URL(string: urlString) {
                self.af.setImage(withURL: url)
            }
        }
    }
}
