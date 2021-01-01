//
//  HomeViewController.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//

import UIKit
import RxSwift
import Moya

final class HomeViewController: UIViewController {
    
    // MARK: - Components
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = R.Colors.almostBlack.color
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var navigationView: NavigationView = {
        let view = NavigationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var filterButtonsView: FilterButtonsView = {
        let filterButtonsView = FilterButtonsView()
        filterButtonsView.translatesAutoresizingMaskIntoConstraints = false
        return filterButtonsView
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionLayout
        )
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - DataSource
    
    lazy var collectionDataSource: HomeViewControllerCollectionDataSource = {
        let collectionDataSource = HomeViewControllerCollectionDataSource()
        collectionDataSource.delegate = self
        return collectionDataSource
    }()
    
    // MARK: - Delegate
    
    lazy var collectionDelegate: HomeViewControllerCollectionDelegate = {
        let collectionDelegate = HomeViewControllerCollectionDelegate()
        collectionDelegate.delegate = self
        return collectionDelegate
    }()
    
    // MARK: - Attributes
    
    var viewModel: HomeViewModel!
    let disposeBag = DisposeBag()
    var radioButtonController: CustomRadioButtonController?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.Colors.dark.color
        setupLayout()
        setupCollectionView()
        setupActions()
        bindViewModel()
        
        radioButtonController = CustomRadioButtonController(
            buttons:
                filterButtonsView.popularButton,
                filterButtonsView.airingTodayButton,
                filterButtonsView.onTvButton,
                filterButtonsView.topRateButton
        )
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
    }
    
    // MARK: - Methods
    
    func bindViewModel() {
        // OUTPUTS
        viewModel.tvShowList
            .do(onNext: { [weak self] elements in
                guard let self = self else { return }
                self.showLoading()
                DispatchQueue.main.async {
                    if elements.results?.count == 0 {
                        self.dismiss(animated: true, completion: {
                            self.collectionView.setEmptyMessage("Test message")
                        })
                    } else {
                        self.dismiss(animated: true, completion: {
                            self.collectionView.restore()
                        })
                    }
                }
            })
            .subscribe(
                onNext: { [weak self] items in
                    guard let self = self else { return }
                    self.dismiss(animated: true, completion: {
                        self.collectionDataSource.items = items.results ?? []
                        self.collectionDelegate.items = items.results ?? []
                        self.collectionView.reloadData()
                    })
                }, onError: { [weak self] error in
                    guard let self = self else { return }
                    self.dismiss(animated: true, completion: {
                        let moyaError: MoyaError = error as! MoyaError
                        self.handleNetworkError(with: moyaError, completitionHandler: nil)
                        self.collectionView.setEmptyMessage("Test message")
                    })
                }
            ).disposed(by: disposeBag)
    }
    
    @objc func handleMenuSelection() {
        self.showAlert(title: "example", message: "message")
    }
    
    private func setupActions() {
        navigationView.menuButton.addTarget(
            self,
            action: #selector(self.handleMenuSelection),
            for: .touchUpInside
        )
    }
    
    override func didSelectTvShow(with tvId: Int) {
        let controller = DetailViewController()
        controller.tvId = tvId
        let viewModel = DetailViewModel(tvShowService: TvShowsService())
        controller.viewModel = viewModel
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func setupCollectionView() {
        collectionView.delegate = collectionDelegate
        collectionView.dataSource = collectionDataSource
        let textFieldCell = UINib(nibName: "TvShowsCollectionViewCell", bundle: nil)
        collectionView.register(textFieldCell, forCellWithReuseIdentifier: "TvShowsCollectionViewCell")
    }
    
    private func setupLayout() {
        view.addSubview(navigationView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(filterButtonsView)
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: K.Components.navigationBarHeight),
            
            scrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
            
            filterButtonsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            filterButtonsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            filterButtonsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            filterButtonsView.heightAnchor.constraint(equalToConstant: 32),
            
            collectionView.topAnchor.constraint(equalTo: filterButtonsView.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
        ])
        
        let contentViewHeightConstraint = contentView.heightAnchor.constraint(
            equalTo: scrollView.heightAnchor
        )
        contentViewHeightConstraint.priority = .defaultLow
        contentViewHeightConstraint.isActive = true
    }
    
}

extension HomeViewController: CustomRadioButtonControllerDelegate {
    func didSelectButton(sender: UIButton?) {
        let tvShowType = TvShowsFilterType(rawValue: sender?.tag ?? 0) ?? .popular
        viewModel.type.onNext(tvShowType)
    }
}

