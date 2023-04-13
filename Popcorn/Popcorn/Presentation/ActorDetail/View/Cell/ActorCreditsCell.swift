//
//  ActorCreditsCell.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 8/4/23.
//

import UIKit

class ActorCreditsCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieImageView.layer.cornerRadius = movieImageView.frame.size.height * 0.08
        movieImageView.clipsToBounds = true
    }
}
