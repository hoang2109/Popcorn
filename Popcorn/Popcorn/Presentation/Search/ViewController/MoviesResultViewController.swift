//
//  MoviesResultViewController.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 6/4/23.
//

import Foundation
import UIKit
import RxSwift

class MoviesResultViewController: UIViewController {
    var onSelect: ((Int) -> ())?
    
    private let viewModel: SearchMovieViewModel!
    private let resultTableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.black
        tableView.rowHeight = 172
        return tableView
    }()
    
    let disposeBag = DisposeBag()
    
    init(viewModel: SearchMovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit MoviesResultViewController")
    }
    
    override func viewDidLoad() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
        
        bind(to: viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func buildViewHierarchy() {
        view.addSubview(resultTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            resultTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            resultTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            resultTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            resultTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureViews() {
        view.backgroundColor = UIColor.black
        
        configureResultTableView()
    }
    
    private func configureResultTableView() {
        let nibName = UINib(nibName: "SearchMovieTableViewCell", bundle: nil)
        resultTableView.register(nibName, forCellReuseIdentifier: "SearchMovieTableViewCell")
    }
    
    private func bind(to viewModel: SearchMovieViewModel) {
        viewModel.searchResultViewState
            .map {
                $0.currentEntities
            }
            .bind(to: resultTableView.rx.items(cellIdentifier: String(describing: SearchMovieTableViewCell.self), cellType: SearchMovieTableViewCell.self)) { (index, element, cell) in
                cell.titleLabel.text = element.title
                cell.posterImageView.imageFromUrl(urlString: element.posterPath, placeHolderImage: UIImage())
                cell.scoreLabel.text = String(format:"%.1f", element.voteAverage) + " (\(String(element.voteCount)))"
            }
            .disposed(by: disposeBag)
        
        Observable
          .zip( resultTableView.rx.itemSelected, resultTableView.rx.modelSelected(Movie.self) )
          .bind { [weak self] (indexPath, item) in
              self?.onSelect?(item.id)
        }
        .disposed(by: disposeBag)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            resultTableView.setBottomInset(to: keyboardHeight)
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        resultTableView.setBottomInset(to: 0.0)
    }
}

extension UITableView {

    func setBottomInset(to value: CGFloat) {
        let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)
        self.contentInset = edgeInset
        self.scrollIndicatorInsets = edgeInset
    }
}
