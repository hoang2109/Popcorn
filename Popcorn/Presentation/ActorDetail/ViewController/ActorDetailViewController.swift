//
//  ActorDetailViewController.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 8/4/23.
//

import UIKit
import RxSwift

class ActorDetailViewController: UIViewController, StoryboardInstantiable {
    
    @IBOutlet weak var actorImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var creditsCollectionView: UICollectionView!
    private let loadingView = LoadingView(frame: .zero)
    
    private var viewModel: ActorDetailViewModel!
    private let disposeBag = DisposeBag()
    
    var onSelect: ((Int) -> ())?
    
    static func create(with viewModel: ActorDetailViewModel) -> ActorDetailViewController {
        let controller = ActorDetailViewController.instantiateViewController()
        controller.viewModel = viewModel
        return controller
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
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
    
    private func configureViews() {
        creditsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    private func bind(to viewModel: ActorDetailViewModel) {
        viewModel.viewState
            .subscribe { [weak self] viewState in
                self?.configView(with: viewState)
            }.disposed(by: disposeBag)
        
        
        viewModel.credits
            .bind(to: creditsCollectionView.rx.items(cellIdentifier: String(describing: ActorCreditsCell.self), cellType: ActorCreditsCell.self)) { (index, element, cell) in
                cell.movieImageView.imageFromUrl(urlString: element.posterPath, placeHolderImage: UIImage())
            }
            .disposed(by: disposeBag)
        
        Observable
            .zip( creditsCollectionView.rx.itemSelected, creditsCollectionView.rx.modelSelected(Movie.self) )
            .bind { [weak self] (indexPath, item) in
                self?.onSelect?(item.id)
            }
            .disposed(by: disposeBag)
    }
    
    private func configView(with state: ViewState<ActorDetail>) {
        loadingView.removeFromSuperview()
        
        if case .loading = state {
            view.addSubview(loadingView)
        }
        
        if case .loaded(let result) = state {
            setupUI(with: result[0])
        }
    }
    
    private func setupUI(with actorDetail: ActorDetail) {
        actorImageView.layer.cornerRadius = 10
        actorImageView.clipsToBounds = true
        
        actorImageView.imageFromUrl(urlString: actorDetail.profilePath, placeHolderImage: UIImage())
        nameLabel.text = actorDetail.name
        bioTextView.text = actorDetail.bio
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
