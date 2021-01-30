//
//  ProfileViewController.swift
//  TMDB
//
//  Created by Byron Chavarría on 4/1/21.
//

import Nuke
import UIKit
import RxSwift

final class ProfileViewController: UIViewController {
    
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
    
    lazy var profileTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString.attributedString(
            L10n.profileTitle,
            font: .boldSystemFont(ofSize: 24),
            color: R.Colors.green.color
        )
        label.attributedText = attributedText
        return label
    }()
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var usernameTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString.attributedString(
            L10n.usernamePlaceholder,
            font: .boldSystemFont(ofSize: 18),
            color: .white
        )
        label.attributedText = attributedText
        return label
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString.attributedString(
            L10n.profileTitle,
            font: .boldSystemFont(ofSize: 12),
            color: R.Colors.green.color
        )
        label.attributedText = attributedText
        return label
    }()
    
    lazy var favoriteShowsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString.attributedString(
            L10n.favoriteShows,
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
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    // MARK: - DataSources
    
    lazy var collectionViewDataSource: ProfileViewControllerCollectionDataSource = {
        let dataSource = ProfileViewControllerCollectionDataSource()
        return dataSource
    }()
    
    // MARK: - Delegates
    
    lazy var collectionViewDelegate: ProfileViewControllerCollectionDelegate = {
        let delegate = ProfileViewControllerCollectionDelegate()
        return delegate
    }()
    
    // MARK: - Attributes
    
    var viewModel: ProfileViewModel!
    let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.Colors.almostBlack.color
        setupLayout()
        setupCollectionView()
        bindViewModel()
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        profileImage.roundImage()
    }
    
    // MARK: - Methods
    
    func bindViewModel() {
        viewModel.getFavoritesTvShows()
            .subscribe(
                onSuccess: { [weak self] response in
                    guard let self = self else { return }
                    if response.count > 0 {
                        self.collectionView.restore()
                        self.collectionViewDataSource.items = response
                        self.collectionView.reloadData()
                    } else {
                        self.collectionView.restore()
                        self.collectionView.setEmptyMessage("You dont have mark as favorite any Tv Show")
                    }
                }, onError: { [weak self] error in
                    guard let self = self else { return }
                    self.collectionView.restore()
                    self.collectionView.setEmptyMessage("You dont have mark as favorite any Tv Show")
                    self.handleError(error)
                }
            ).disposed(by: disposeBag)
    }
    
    func setupProfileInfo(with userInfo: AccountModel) {
        let options = K.NukeDefault.options
        let url = URL(string: "\(DefaultPreferences.current.loadImageBaseString ?? "")\(userInfo.imagePath ?? "")")!
        if userInfo.imagePath != "" {
            Nuke.loadImage(with: url, options: options, into: profileImage)
        } else {
            profileImage.image = UIImage(data: userInfo.imageData ?? Data())
        }

        usernameLabel.text = "@\(userInfo.username ?? "username")"
    }
    
    func setupCollectionView() {
        collectionView.showLoagin(with: "Getting info")
        collectionView.delegate = collectionViewDelegate
        collectionView.dataSource = collectionViewDataSource
        collectionView.register(cellType: TvShowsCollectionViewCell.self)
    }
    
    private func setupLayout() {
        roundtopView.addSubview(guideView)
        view.addSubview(roundtopView)
        
        view.addSubview(profileTitleLabel)
        view.addSubview(profileImage)
        view.addSubview(usernameTitleLabel)
        view.addSubview(usernameLabel)
        view.addSubview(favoriteShowsLabel)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            guideView.centerYAnchor.constraint(equalTo: roundtopView.centerYAnchor),
            guideView.centerXAnchor.constraint(equalTo: roundtopView.centerXAnchor),
            
            guideView.widthAnchor.constraint(equalToConstant: 36),
            guideView.heightAnchor.constraint(equalToConstant: 5),
            
            roundtopView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            roundtopView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            roundtopView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            roundtopView.heightAnchor.constraint(equalToConstant: 16),
            
            profileTitleLabel.topAnchor.constraint(equalTo: roundtopView.bottomAnchor, constant: 40),
            profileTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            profileImage.topAnchor.constraint(equalTo: profileTitleLabel.bottomAnchor, constant: 40),
            profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            profileImage.widthAnchor.constraint(equalToConstant: 130),
            profileImage.heightAnchor.constraint(equalToConstant: 130),
            
            usernameTitleLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 32),
            usernameTitleLabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor, constant: -8),
            
            usernameLabel.topAnchor.constraint(equalTo: usernameTitleLabel.bottomAnchor, constant: 8),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 32),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            favoriteShowsLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 40),
            favoriteShowsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            
            collectionView.topAnchor.constraint(equalTo: favoriteShowsLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
        ])
    }
}
