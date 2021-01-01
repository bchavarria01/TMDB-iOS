//
//  SeasonTableViewCell.swift
//  TMDB
//
//  Created by Byron Chavarría on 31/12/20.
//

import UIKit

class SeasonTableViewCell: UITableViewCell {
    
    //MARK: - Components
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var seasonName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString.attributedString(
            "Season 1",
            font: .boldSystemFont(ofSize: 18),
            color: R.Colors.green.color
        )
        label.attributedText = attributedText
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionLayout
        )
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - DataSource
    
    lazy var collectionDataSource: SeasonTableViewCollectionDataSource = {
        let collectionDataSource = SeasonTableViewCollectionDataSource()
        return collectionDataSource
    }()
    
    // MARK: - Delegate
    
    lazy var collectionDelegate: SeasonTableViewCollectionDelegate = {
        let collectionDelegate = SeasonTableViewCollectionDelegate()
        return collectionDelegate
    }()
    
    //MARK: - Attributes
    
    //MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Methods
    
    func setupCollectionView() {
        collectionView.delegate = collectionDelegate
        collectionView.dataSource = collectionDataSource
        let textFieldCell = UINib(nibName: "SeasonCollectionViewCell", bundle: nil)
        collectionView.register(textFieldCell, forCellWithReuseIdentifier: "SeasonCollectionViewCell")
    }
    
    func setupEpisodes(with listOfEpisodes: [Episode]) {
        collectionDataSource.items = listOfEpisodes
        collectionView.reloadData()
    }
    
    func setupLayout() {
        contentView.addSubview(seasonName)
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            
            seasonName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            seasonName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            collectionView.topAnchor.constraint(equalTo: seasonName.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
}
