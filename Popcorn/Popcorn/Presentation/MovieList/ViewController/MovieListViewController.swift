//
//  MovieListViewController.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 6/4/23.
//

import UIKit
import RxSwift
import Common

class MovieListViewController: UITableViewController, StoryboardInstantiable {
    
    private var loadingView = LoadingView(frame: .zero)
    
    private var viewModel: MovieListViewModel!
    private let disposeBag = DisposeBag()
    
    static func create(with viewModel: MovieListViewModel) -> MovieListViewController {
        let controller = MovieListViewController.instantiateViewController()
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
      print("deinit \(Self.self)")
    }
    
    private func configureViews() {
        configureNavigationBar()
        configureResultTableView()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func configureResultTableView() {
        tableView.backgroundColor = .clear
        let nibName = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "MovieTableViewCell")
        tableView.rowHeight = 172
        tableView.delegate = nil
        tableView.dataSource = nil
        let refreshControl = UIRefreshControl(frame: .zero)
        refreshControl.tintColor = .white
        tableView.refreshControl = refreshControl
    }
    
    private func bind(to viewModel: MovieListViewModel) {
        viewModel.moviesViewState
          .subscribe(onNext: { [weak self] state in
            self?.configView(with: state)
          })
          .disposed(by: disposeBag)
        
        viewModel.moviesViewState
            .map { $0.currentEntities }
            .bind(to: tableView.rx.items(cellIdentifier: String(describing: MovieTableViewCell.self), cellType: MovieTableViewCell.self)) { [weak self] (index, element, cell) in
                cell.titleLabel.text = element.title
                cell.posterImageView.imageFromUrl(urlString: element.posterPath, placeHolderImage: UIImage())
                cell.scoreLabel.text = String(format:"%.1f", element.voteAverage) + " (\(String(element.voteCount)))"
                
                if case .paging(let entities, let nextPage) = try? self?.viewModel.moviesViewStateSubject.value(),
                  index == entities.count - 1 {
                    self?.viewModel.getMovies(page: nextPage)
                }
            }
            .disposed(by: disposeBag)
        
        tableView.refreshControl?.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.reloadData()
            })
            .disposed(by: disposeBag)
        
        Observable
            .zip( tableView.rx.itemSelected, tableView.rx.modelSelected(Movie.self) )
            .bind { [weak self] (indexPath, item) in
                self?.viewModel.didSelectMovie(item.id)
            }
            .disposed(by: disposeBag)
    }
    
    func configView(with state: ViewState<Movie>) {
        if let refreshing = tableView.refreshControl?.isRefreshing, refreshing {
            tableView.refreshControl?.endRefreshing()
        }
        
        switch state {
        case .loading:
            tableView.refreshControl?.beginRefreshing()
        case .loaded:
            tableView.tableFooterView = nil
            tableView.separatorStyle = .singleLine
        case .empty:
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
        case .paging:
            tableView.tableFooterView = loadingView
            tableView.separatorStyle = .singleLine
        default:
            tableView.tableFooterView = loadingView
        }
    }
}
