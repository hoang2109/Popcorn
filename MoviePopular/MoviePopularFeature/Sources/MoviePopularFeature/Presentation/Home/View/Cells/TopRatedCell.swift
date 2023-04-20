//
//  TopRatedCell.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 2/4/23.
//

import UIKit
import Common

class TopRatedCell: UICollectionViewCell {
    
    var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var view = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var titleLabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.label
        label.numberOfLines = 0
        label.textAlignment = .left
        
        return label
    }()
    
    var imdbLabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .systemOrange
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    var releaseLabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .systemOrange
        label.numberOfLines = 0
        label.textAlignment = .left
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
        addSubViews(view: view, posterImageView, titleLabel, imdbLabel, releaseLabel)
        posterImageView.bringSubviewToFront(view)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo:centerXAnchor),
            view.centerYAnchor.constraint(equalTo: centerYAnchor),
            view.widthAnchor.constraint(equalTo: widthAnchor,constant: -30),
            view.heightAnchor.constraint(equalToConstant: 120),
                        
            posterImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            posterImageView.heightAnchor.constraint(equalToConstant: 150),
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor,constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: releaseLabel.topAnchor),
                       
            imdbLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imdbLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -5),
            imdbLabel.widthAnchor.constraint(equalToConstant: 40),
            imdbLabel.heightAnchor.constraint(equalToConstant: 40),
            
            releaseLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            releaseLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            releaseLabel.trailingAnchor.constraint(equalTo: imdbLabel.leadingAnchor),
            releaseLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func configureViews() {
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
    }
    
    func setup(movieInfo: Movie){
        posterImageView.imageFromUrl(urlString: movieInfo.posterPath, placeHolderImage: UIImage())
        titleLabel.text = movieInfo.title
        imdbLabel.text = "\(movieInfo.voteAverage)"
        releaseLabel.text = movieInfo.releaseDate
    }
}
