//
//  HomeViewController.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 2/4/23.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class HomeViewController: UICollectionViewController {
    
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl(frame: .zero)
        refreshControl.tintColor = .white
        return refreshControl
    }()
    
    private var viewModel : HomeViewModel!
    private var disposeBag = DisposeBag()
    
    convenience init(_ viewModel: HomeViewModel) {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.viewModel = viewModel
    }
    
    deinit {
      print("deinit \(Self.self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    func configureViews() {
        view.backgroundColor = .black
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        configureCollectionView()
        registerOurCells()
    }
    
    private func configureCollectionView() {
        collectionView.collectionViewLayout = HomeCollectionViewLayout.createLayouts()
        collectionView.backgroundColor = .black
        collectionView.refreshControl = refreshControl
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = nil
        collectionView.delegate = nil
    }
    
    private func registerOurCells(){
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: String(describing: PopularCell.self))
        collectionView.register(TopRatedCell.self, forCellWithReuseIdentifier: String(describing: TopRatedCell.self))
        collectionView.register(UpcomingCell.self, forCellWithReuseIdentifier: String(describing: UpcomingCell.self))
        collectionView.register(LatestCell.self, forCellWithReuseIdentifier: String(describing: LatestCell.self))
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: String(describing: PopularCell.self))
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: HeaderView.self))
    }
    
    private func bind(to viewModel: HomeViewModel) {
        let configureCollectionViewDS = configureCollectionViewDataSource()
        let dataSource = RxCollectionViewSectionedReloadDataSource<HomeSectionModel>(configureCell: configureCollectionViewDS.configureCell, configureSupplementaryView: configureCollectionViewDS.configureSupplementaryView)
        
        viewModel
            .moviesSections
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        viewModel
            .isRefreshing
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.refreshMovies()
            })
            .disposed(by: disposeBag)
        
        
        Observable
          .zip( collectionView.rx.itemSelected, collectionView.rx.modelSelected(Movie.self) )
          .bind { [weak self] (indexPath, item) in
              self?.viewModel.didSelectMovie(item.id)
        }
        .disposed(by: disposeBag)
    }
    
    private func configureCollectionViewDataSource() -> (
        configureCell: CollectionViewSectionedDataSource<HomeSectionModel>.ConfigureCell,  configureSupplementaryView: CollectionViewSectionedDataSource<HomeSectionModel>.ConfigureSupplementaryView ) {
            let configureCell: CollectionViewSectionedDataSource<HomeSectionModel>.ConfigureCell = { dataSource, collectionView, indexPath, item in
                let section = dataSource[indexPath.section]
                switch section {
                case .popularMovies:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PopularCell.self), for: indexPath) as! PopularCell
                    cell.setup(movie: item, itemIndex: (indexPath.item + 1))
                    return cell
                case .topRatedMovies:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TopRatedCell.self), for: indexPath) as! TopRatedCell
                    cell.setup(movieInfo: item)
                    return cell
                case .upcomingMovies:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UpcomingCell.self), for: indexPath) as! UpcomingCell
                    if let image = item.posterPath {
                        cell.setup(imagePath: image)
                    }
                    return cell
                case .latestMovies:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LatestCell.self), for: indexPath) as! LatestCell
                    if let image = item.posterPath {
                        cell.setup(imagePath: image)
                    }
                    return cell
                }
            }

            let configureSupplementaryView: CollectionViewSectionedDataSource<HomeSectionModel>.ConfigureSupplementaryView = {(dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
                let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: HeaderView.self), for: indexPath) as! HeaderView
                let cateId = dataSource[indexPath.section].key
                let title = dataSource[indexPath.section].title
                headerCell.label.text = title
                headerCell.onTap = { [weak self] in
                    self?.viewModel.didSelectMovieCategory(cateId, title)
                }
                return headerCell
            }

            return (configureCell, configureSupplementaryView)
        }
        
}
