//
//  HomeViewController.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Components
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
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
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.Colors.dark.color
        setupLayout()
        setupCollectionView()
    }
    
    // MARK: - Methods
    
    override func didSelectTvShow() {
        let controller = DetailViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func setupCollectionView() {
        collectionView.delegate = collectionDelegate
        collectionView.dataSource = collectionDataSource
        let textFieldCell = UINib(nibName: "TvShowsCollectionViewCell", bundle: nil)
        collectionView.register(textFieldCell, forCellWithReuseIdentifier: "TvShowsCollectionViewCell")
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(filterButtonsView)
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
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

