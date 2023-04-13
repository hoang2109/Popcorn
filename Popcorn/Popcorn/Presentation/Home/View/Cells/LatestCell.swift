//
//  LatestCell.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 2/4/23.
//

import UIKit

class LatestCell: UICollectionViewCell {
    
    var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(posterImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            posterImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 150),
            posterImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setup(imagePath: String){
        posterImageView.imageFromUrl(urlString: imagePath, placeHolderImage: UIImage())
    }
}
