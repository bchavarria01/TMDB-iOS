//
//  SeasonsViewController.swift
//  TMDB
//
//  Created by Byron Chavarría on 31/12/20.
//

import Moya
import UIKit
import RxSwift

final class SeasonsViewController: UIViewController {
    
    // MARK: - Components
    
    lazy var roundtopView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = R.Colors.almostBlack.color
        return view
    }()
    
    lazy var guideView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.cornerRadius(with: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], cornerRadii: 4)
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = R.Colors.almostBlack.color
        tableView.isUserInteractionEnabled = true
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - TableView DataSource
    
    lazy var tableViewDataSource: SeasonTableViewDataSource = {
        let dataSource = SeasonTableViewDataSource()
        return dataSource
    }()
    
    // MARK: - TableView Delegate
    
    lazy var tableViewDelegate: SeasonTableViewDelegate = {
        let delegate = SeasonTableViewDelegate()
        return delegate
    }()
    
    // MARK: - Attributes
    
    var tvId: Int?
    var numberOfSeasons: Int?
    var viewModel: SeasonsViewModel!
    let disposeBag = DisposeBag()
    var episodeList: [EpisodesModel] = []
    var currentSeason: Int = 1
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.Colors.almostBlack.color
        setupLayout()
        setupTableView()
        
        let status = Reachability().connectionStatus()
        bindViewModel(with: status)
    }
    
    // MARK: - Methods
    
    func bindViewModel(with status: ReachabilityStatus) {
        
        var viewModelList: Observable<EpisodesModel?>
        switch status {
        case .unknown, .offline:
            viewModelList = viewModel.localseasonsList
        case .online(.wwan):
            viewModelList = viewModel.seasonsList
        case .online(.wiFi):
            viewModelList = viewModel.seasonsList
        }
        
        viewModelList
            .do(onNext: { [weak self] elements in
                guard let self = self else { return }
                _ = self
                if elements == nil {
                    self.tableView.setEmptyMessage("Seasons info not found")
                }
            }).subscribe(
                onNext: { [weak self] data in
                    guard let self = self else { return }
                    self.episodeList.append(data!)
                    if self.numberOfSeasons ?? 0 > self.currentSeason {
                        self.currentSeason += 1
                        self.viewModel.seasonId.onNext(self.currentSeason)
                    } else {
                        self.tableViewDataSource.items = self.episodeList
                        self.tableView.restore()
                        self.tableView.reloadData()
                    }
                }, onError: { [weak self] error in
                    guard let self = self else { return }
                    self.dismiss(animated: true, completion: {
                        self.tableView.setEmptyMessage("Seasons info not found")
                        self.handleError(error)
                    })
                }
            ).disposed(by: disposeBag)
        viewModel.tvId.onNext(tvId ?? 0)
    }
    
    private func setupTableView() {
        tableView.showLoagin(with: "Loading seasons info")
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        tableView.register(SeasonTableViewCell.self, forCellReuseIdentifier: "SeasonTableViewCell")
    }
    
    private func setupLayout() {
        roundtopView.addSubview(guideView)
        view.addSubview(roundtopView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            guideView.centerYAnchor.constraint(equalTo: roundtopView.centerYAnchor),
            guideView.centerXAnchor.constraint(equalTo: roundtopView.centerXAnchor),
            
            guideView.widthAnchor.constraint(equalToConstant: 36),
            guideView.heightAnchor.constraint(equalToConstant: 5),
            
            roundtopView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            roundtopView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            roundtopView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            roundtopView.heightAnchor.constraint(equalToConstant: 16),
            
            tableView.topAnchor.constraint(equalTo: roundtopView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
}

