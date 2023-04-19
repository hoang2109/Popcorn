//
//  MovieDetailViewController.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Common

class MovieDetailViewController: UIViewController, StoryboardInstantiable {
    
    @IBOutlet weak var posterView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieScoreLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var addWatchlistButton: UIButton!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var trailerCollectionView: UICollectionView!
    private let loadingView = LoadingView(frame: .zero)
    
    private var viewModel : MovieDetailViewModel!
    
    private var disposeBag = DisposeBag()
    
    static func create(with viewModel: MovieDetailViewModel) -> MovieDetailViewController {
        let controller = MovieDetailViewController.instantiateViewController(Bundle.LibraryName)
        controller.viewModel = viewModel
        return controller
    }
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        loadingView.frame = view.frame
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    deinit {
        viewModel.viewDidFinish()
        print("deinit \(Self.self)")
    }
    
    private func configureViews() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.darkText.cgColor
        ]
        gradient.frame.size.height = posterView.frame.height
        gradient.frame.size.width = posterView.frame.width * 20
        posterView.layer.addSublayer(gradient)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func bind(to viewModel: MovieDetailViewModel) {
        viewModel.movieInfoViewState.subscribe(onNext: { [weak self] viewState in
            self?.configView(with: viewState)
        })
        .disposed(by: disposeBag)
        
        viewModel
            .creditsViewState
            .map { $0.currentEntities }
            .bind(to: castCollectionView.rx.items(cellIdentifier: String(describing: CreditsCollectionViewCell.self), cellType: CreditsCollectionViewCell.self )) { [weak self] (index, element, cell) in
                guard let _ = self else { return }
                
                cell.castName.text = element.name
                cell.castImage.layer.cornerRadius = cell.castImage.frame.size.height * 0.1
                if let posterPath = element.profilePath {
                    cell.castImage.imageFromUrl(urlString: posterPath, placeHolderImage: UIImage())
                }
            }
            .disposed(by: disposeBag)
        
        
        viewModel
            .videosViewState
            .map { $0.currentEntities }
            .bind(to: trailerCollectionView.rx.items(cellIdentifier: String(describing: TrailerCollectionViewCell.self), cellType: TrailerCollectionViewCell.self )) { [weak self] (index, element, cell) in
                guard let _ = self else { return }
                let videoKey = element.key
                if let url = URL(string: "https://www.youtube.com/embed/\(videoKey)") {
                    cell.trailerWebView.load(URLRequest(url: url))
                }
            }
            .disposed(by: disposeBag)
        
        Observable
            .zip( castCollectionView.rx.itemSelected, castCollectionView.rx.modelSelected(Cast.self) )
            .bind { [weak self] (indexPath, item) in
                self?.viewModel.didSelectActor(item.id)
            }
            .disposed(by: disposeBag)
    }
    
    private func configView(with state: ViewState<MovieDetailInfo>) {
        loadingView.removeFromSuperview()
        
        if case .loading = state {
            view.addSubview(loadingView)
        }
        
        if case .loaded(let result) = state {
            setupUI(with: result[0])
        }
    }
    
    private func setupUI(with movieInfo: MovieDetailInfo) {
        movieTitleLabel.text = movieInfo.title
        movieYearLabel.text = movieInfo.dateAndGenre
        movieScoreLabel.text = movieInfo.score
        movieOverviewLabel.text = movieInfo.overview
        posterImageView.imageFromUrl(urlString: movieInfo.posterPath, placeHolderImage: UIImage())
    }
    
    //MARK: - Actions
    @IBAction func watchListButtonPressed(_ sender: UIButton) {
        print("Watchlist button pressed.")
    }
}
