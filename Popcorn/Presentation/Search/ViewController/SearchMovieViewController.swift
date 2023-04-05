//
//  SearchMovieViewController.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 5/4/23.
//

import UIKit
import RxSwift

class SearchMovieViewController: UIViewController, StoryboardInstantiable {

    @IBOutlet weak var searchTableView: UITableView!
    var viewModel: SearchMovieViewModel!
    
    private let disposeBag = DisposeBag()
    
    static func create(with viewModel: SearchMovieViewModel) -> SearchMovieViewController {
        let controller = SearchMovieViewController.instantiateViewController()
        controller.viewModel = viewModel
        return controller
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    deinit {
        print("deinit SearchMovieViewController")
    }
    
    func configureViews() {
        searchTableView.rowHeight = 172
    }
    
    private func bind(to viewModel: SearchMovieViewModel) {
        viewModel.discoverMoviesViewState
            .map { $0.currentEntities }
            .bind(to: searchTableView.rx.items(cellIdentifier: String(describing: SearchMovieTableViewCell.self), cellType: SearchMovieTableViewCell.self)) { [weak self] (index, element, cell) in
                guard let self = self else { return }
                cell.titleLabel.text = element.title
                cell.posterImageView.imageFromUrl(urlString: element.posterPath, placeHolderImage: UIImage())
                cell.scoreLabel.text = String(format:"%.1f", element.voteAverage) + " (\(String(element.voteCount)))"
            }
            .disposed(by: disposeBag)
    }
}
