//
//  PopularCell.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 2/4/23.
//

import UIKit

class PopularCell: UICollectionViewCell {
    
    var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var rankingLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(posterImageView)
        addSubview(rankingLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo:topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 50),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 20),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
                        
            rankingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            rankingLabel.widthAnchor.constraint(equalToConstant: 250),
            rankingLabel.heightAnchor.constraint(equalToConstant: 120),
            rankingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
        ])
    }
    
    func configureViews() {
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.5)
        layer.shadowOpacity = 0.2
    }
    
    func setup(movie: Movie, itemIndex: Int) {
        posterImageView.imageFromUrl(urlString: movie.posterPath, placeHolderImage: UIImage())
        configureLabel(itemIndex: String(itemIndex))
    }
    
    func configureLabel(itemIndex: String){
        let strokeTextAttributes = [
            NSAttributedString.Key.strikethroughColor : UIColor.black,
            NSAttributedString.Key.strokeColor : UIColor.white,
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.strokeWidth : -2.0,
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 150),]
        as [NSAttributedString.Key : Any]

        rankingLabel.attributedText = NSMutableAttributedString(string: itemIndex, attributes: strokeTextAttributes)
    }
}
