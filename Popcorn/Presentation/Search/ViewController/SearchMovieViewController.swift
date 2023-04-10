//
//  SearchMovieViewController.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 5/4/23.
//

import UIKit
import RxSwift

protocol SearchMovieViewControllerDelegate: AnyObject {
    func didSelectMovie(_ movieId: Int)
}

class SearchMovieViewController: UIViewController, StoryboardInstantiable {
    
    @IBOutlet weak var discoveryMoviesTableView: UITableView!
    private var searchController: UISearchController!
    
    private var viewModel: SearchMovieViewModel!
    private weak var delegate: SearchMovieViewControllerDelegate?
    
    private let disposeBag = DisposeBag()
    
    static func create(with viewModel: SearchMovieViewModel, _ delegate: SearchMovieViewControllerDelegate?) -> SearchMovieViewController {
        let controller = SearchMovieViewController.instantiateViewController()
        controller.viewModel = viewModel
        controller.delegate = delegate
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
      print("deinit \(Self.self)")
    }
    
    private func configureViews() {
        configureNavigationBar()
        configureResultTableView()
        configureSearchBarController()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func configureSearchBarController() {
        let resultsController = MoviesResultViewController(viewModel: viewModel)
        resultsController.onSelect = { [weak self] in
            self?.delegate?.didSelectMovie($0)
        }
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchBar.placeholder = "Search for a movie"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func configureResultTableView() {
        let nibName = UINib(nibName: "SearchMovieTableViewCell", bundle: nil)
        discoveryMoviesTableView.register(nibName, forCellReuseIdentifier: "SearchMovieTableViewCell")
        discoveryMoviesTableView.rowHeight = 172
    }
    
    private func bind(to viewModel: SearchMovieViewModel) {
        searchController.searchBar.rx.text.orEmpty
            .do(onNext: { [weak self] in
                if $0.count == 0 {
                    self?.viewModel.clearSearchResult()
                }
            })
            .filter { $0.count > 0 }
            .debounce(.milliseconds(1000), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] (text) in
                self?.viewModel.searchMovie(query: text)
            })
            .disposed(by: disposeBag)
        
        viewModel.discoverMoviesViewState
            .map { $0.currentEntities }
            .bind(to: discoveryMoviesTableView.rx.items(cellIdentifier: String(describing: SearchMovieTableViewCell.self), cellType: SearchMovieTableViewCell.self)) {  (index, element, cell) in
                cell.titleLabel.text = element.title
                cell.posterImageView.imageFromUrl(urlString: element.posterPath, placeHolderImage: UIImage())
                cell.scoreLabel.text = String(format:"%.1f", element.voteAverage) + " (\(String(element.voteCount)))"
            }
            .disposed(by: disposeBag)
        
        Observable
          .zip( discoveryMoviesTableView.rx.itemSelected, discoveryMoviesTableView.rx.modelSelected(Movie.self) )
          .bind { [weak self] (indexPath, item) in
              self?.delegate?.didSelectMovie(item.id)
        }
        .disposed(by: disposeBag)
    }
}


// MARK: - UISearchBarDelegate

extension SearchMovieViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.clearSearchResult()
    }
}
