//
//  DetailViewController.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//

import UIKit
import Nuke
import RxSwift
import Moya

final class DetailViewController: UIViewController {
    
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
    
    lazy var tvShowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = R.Base.placeholder.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var rateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = R.Colors.green.color
        return view
    }()
    
    lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString.attributedString("8.6", font: .systemFont(ofSize: 18), color: .white)
        label.attributedText = attributedText
        return label
    }()
    
    lazy var mainBackVIew: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = R.Colors.gray.color
        return view
    }()
    
    lazy var summaryTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString.attributedString(L10n.summary, font: .systemFont(ofSize: 18), color: R.Colors.green.color)
        label.attributedText = attributedText
        return label
    }()
    
    lazy var tvShowName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString.attributedString("-", font: .systemFont(ofSize: 18), color: .white)
        label.attributedText = attributedText
        return label
    }()
    
    lazy var favButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("♡", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.setTitleColor(R.Colors.green.color, for: .normal)
        return button
    }()

    
    lazy var tvShowDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString.attributedString("-", font: .systemFont(ofSize: 12), color: .white)
        label.attributedText = attributedText
        label.numberOfLines = 0
        return label
    }()
    
    lazy var tvShowCreatedBy: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString.attributedString(L10n.createdBy, font: .boldSystemFont(ofSize: 12), color: .white)
        label.attributedText = attributedText
        return label
    }()
    
    lazy var lastSeasonTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString.attributedString(L10n.lastSeason, font: .boldSystemFont(ofSize: 18), color: R.Colors.green.color)
        label.attributedText = attributedText
        return label
    }()
    
    lazy var lastSeasonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = R.Base.placeholder.image
        imageView.contentMode = .redraw
        return imageView
    }()
    
    lazy var lastSeasonName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString.attributedString("Season 4", font: .boldSystemFont(ofSize: 16), color: .white)
        label.attributedText = attributedText
        return label
    }()
    
    lazy var lastSeasonReleaseDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString.attributedString("Nov 10, 19", font: .systemFont(ofSize: 10), color: R.Colors.green.color)
        label.attributedText = attributedText
        return label
    }()
    
    lazy var viewAllSeasonButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.setTitle(L10n.viewAllSeasonActiom, for: .normal)
        button.backgroundColor = R.Colors.green.color
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10)
        return button
    }()
    
    lazy var castTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString.attributedString(L10n.cast, font: .boldSystemFont(ofSize: 18), color: R.Colors.green.color)
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
        return collectionView
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.backAction, for: .normal)
        button.setTitleColor(.white, for: .normal)
        let image = UIImage(systemName: "chevron.backward")
        image?.withTintColor(.white, renderingMode: .alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    // MARK: - DataSource
    
    lazy var collectionDataSource: DetailViewControllerCollectionDataSource = {
        let collectionDataSource = DetailViewControllerCollectionDataSource()
        collectionDataSource.delegate = self
        return collectionDataSource
    }()
    
    // MARK: - Delegate
    
    lazy var collectionDelegate: DetailViewControllerCollectionDelegate = {
        let collectionDelegate = DetailViewControllerCollectionDelegate()
        return collectionDelegate
    }()
    
    // MARK: - Attributes
    
    var viewModel: DetailViewModel!
    var tvId: Int?
    var numberOfSeasons: Int?
    let disposeBag = DisposeBag()
    weak var delegate: DetailViewControllerDelegate?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.Colors.almostBlack.color
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        
        setupMainBackView()
        setupLayout()
        setupActions()
        
        mainBackVIew.cornerRadius(with: [.layerMaxXMinYCorner, .layerMinXMinYCorner], cornerRadii: 10)
        setupCollectionView()
        showLoading()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let status = Reachability().connectionStatus()
        bindViewModel(with: status)
    }
    
    // MARK: - Methods
    
    func setupCollectionView() {
        collectionView.dataSource = collectionDataSource
        collectionView.delegate = collectionDelegate
        collectionView.register(cellType: CastCollectionCell.self)
    }
    
    func setupActions() {
        viewAllSeasonButton.addTarget(
            self,
            action: #selector(self.handleViewAllSeasonsSelection(_:)),
            for: .touchUpInside
        )
        
        backButton.addTarget(
            self,
            action: #selector(self.handleBackAction(_:)),
            for: .touchUpInside
        )
    }
    
    @objc private func handleBackAction(_ sender: UIButton) {
        delegate?.detailViewControllerDidSelectBack()
    }
    
    @objc private func handleViewAllSeasonsSelection(_ sender: UIButton) {
        delegate?.detialViewControllerDidSelectViewAllSeasons(wit: self.tvId ?? 0, and: self.numberOfSeasons ?? 0)
    }
    
    func bindViewModel(with status: ReachabilityStatus) {
        switch status {
        case .unknown, .offline:
            getLocalTvShowDetail()
        case .online(.wwan):
            getTvShowDetail()
        case .online(.wiFi):
            getTvShowDetail()
        }
    }
    
    func getTvShowDetail() {
        viewModel.getTvShowDetail(with: self.tvId ?? 0)
            .subscribe(
                onSuccess: { [weak self] response in
                    guard let self = self else { return }
                    self.numberOfSeasons = response.numberOfSeasons
                    self.setupTvShowContent(with: response)
                    
                    self.dismiss(animated: true, completion: {
                        self.showLoading()
                        self.viewModel.getCast(with: self.tvId ?? 0)
                            .subscribe(
                                onSuccess: { [weak self] response in
                                    guard let self = self else { return }
                                    self.dismiss(animated: true, completion: {
                                        self.collectionDataSource.items = response
                                        self.collectionView.reloadData()
                                    })
                                }, onError: { [weak self] error in
                                    guard let self = self else { return }
                                    self.dismiss(animated: true, completion: {
                                        self.handleError(error)
                                    })
                                }
                            ).disposed(by: self.disposeBag)
                    })
                    
                }, onError: { [weak self] error in
                    guard let self = self else { return }
                    self.dismiss(animated: true, completion: {
                        self.handleError(error)
                    })
                }
            ).disposed(by: disposeBag)
    }
    
    func getLocalTvShowDetail() {
        viewModel.getLocalTvShowDetail(with: self.tvId ?? 0)
            .subscribe(
                onSuccess: { [weak self] response in
                    guard let self = self else { return }
                    self.numberOfSeasons = response.numberOfSeasons
                    self.setupTvShowContent(with: response)
                    
                    self.dismiss(animated: true, completion: {
                        self.showLoading()
                        self.viewModel.getLocalCast(with: self.tvId ?? 0)
                            .subscribe(
                                onSuccess: { [weak self] response in
                                    guard let self = self else { return }
                                    self.dismiss(animated: true, completion: {
                                        self.collectionDataSource.items = response
                                        self.collectionView.reloadData()
                                    })
                                }, onError: { [weak self] error in
                                    guard let self = self else { return }
                                    self.dismiss(animated: true, completion: {
                                        self.handleError(error)
                                    })
                                }
                            ).disposed(by: self.disposeBag)
                    })
                    
                }, onError: { [weak self] error in
                    guard let self = self else { return }
                    self.dismiss(animated: true, completion: {
                        self.handleError(error)
                    })
                }
            ).disposed(by: disposeBag)
    }
    
    func setupTvShowContent(with tvShowInfo: TvShowsDetailModel) {
        let options = K.NukeDefault.options
        if tvShowInfo.posterPath != "" {
            let url = URL(string: "\(DefaultPreferences.current.loadImageBaseString ?? "")\(tvShowInfo.posterPath ?? "")")!
            Nuke.loadImage(with: url, options: options, into: tvShowImage)
        } else {
            tvShowImage.image = UIImage(data: tvShowInfo.detailImageData ?? Data())
        }
        tvShowName.text = tvShowInfo.name
        tvShowDescription.text = tvShowInfo.overview
        tvShowCreatedBy.text = tvShowInfo.createdBy
        
        rateLabel.text = String(format: "%.1f", tvShowInfo.voteAverage ?? 0)
        
        if tvShowInfo.lastSeasonImagePath != "" {
            let options = K.NukeDefault.options
            let url2 = URL(string: "\(DefaultPreferences.current.loadImageBaseString ?? "")\(tvShowInfo.lastSeasonImagePath ?? "")")!
            Nuke.loadImage(with: url2, options: options, into: lastSeasonImage)
        } else {
            lastSeasonImage.image = UIImage(data: tvShowInfo.lastSeasonImageData ?? Data())
        }
        
        lastSeasonName.text = tvShowInfo.lastSeasonName
        lastSeasonReleaseDate.text = tvShowInfo.lastSeasonReleaseDate
    }
    
    private func setupMainBackView() {
        rateView.addSubview(rateLabel)
        rateView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        rateView.layer.cornerRadius = rateView.frame.size.height/2
        
        mainBackVIew.addSubview(summaryTitle)
        mainBackVIew.addSubview(rateView)
        mainBackVIew.addSubview(tvShowName)
        mainBackVIew.addSubview(favButton)
        mainBackVIew.addSubview(tvShowDescription)
        mainBackVIew.addSubview(tvShowCreatedBy)
        mainBackVIew.addSubview(lastSeasonTitle)
        mainBackVIew.addSubview(lastSeasonImage)
        mainBackVIew.addSubview(lastSeasonName)
        mainBackVIew.addSubview(lastSeasonReleaseDate)
        mainBackVIew.addSubview(viewAllSeasonButton)
        mainBackVIew.addSubview(castTitle)
        mainBackVIew.addSubview(collectionView)
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(tvShowImage)
        contentView.addSubview(backButton)
        contentView.addSubview(mainBackVIew)
        
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
            
            tvShowImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            tvShowImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tvShowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tvShowImage.heightAnchor.constraint(equalToConstant: 211),
            
            backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            mainBackVIew.topAnchor.constraint(equalTo: tvShowImage.bottomAnchor, constant: -32),
            mainBackVIew.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            mainBackVIew.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            mainBackVIew.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            //summaryTitle
            
            summaryTitle.topAnchor.constraint(equalTo: mainBackVIew.topAnchor, constant: 20),
            summaryTitle.leadingAnchor.constraint(equalTo: mainBackVIew.leadingAnchor, constant: 24),
            
            //rateView
            
            rateView.topAnchor.constraint(equalTo: mainBackVIew.topAnchor, constant: -20),
            rateView.trailingAnchor.constraint(equalTo: mainBackVIew.trailingAnchor, constant: -40),
            rateView.widthAnchor.constraint(equalToConstant: 40),
            rateView.heightAnchor.constraint(equalToConstant: 40),
            
            rateLabel.centerYAnchor.constraint(equalTo: rateView.centerYAnchor),
            rateLabel.centerXAnchor.constraint(equalTo: rateView.centerXAnchor),
            
            //tvShowName
            
            tvShowName.topAnchor.constraint(equalTo: summaryTitle.bottomAnchor, constant: 12),
            tvShowName.leadingAnchor.constraint(equalTo: mainBackVIew.leadingAnchor, constant: 24),
            
            //favButton
            
            favButton.centerYAnchor.constraint(equalTo: tvShowName.centerYAnchor),
            favButton.trailingAnchor.constraint(equalTo: mainBackVIew.trailingAnchor, constant: -42),
            
            //tvShowDescription
            
            tvShowDescription.topAnchor.constraint(equalTo: tvShowName.bottomAnchor, constant: 20),
            tvShowDescription.leadingAnchor.constraint(equalTo: mainBackVIew.leadingAnchor, constant: 20),
            tvShowDescription.trailingAnchor.constraint(equalTo: mainBackVIew.trailingAnchor, constant: -20),
            
            //tvShowCreatedBy
            
            tvShowCreatedBy.topAnchor.constraint(equalTo: tvShowDescription.bottomAnchor, constant: 12),
            tvShowCreatedBy.leadingAnchor.constraint(equalTo: mainBackVIew.leadingAnchor, constant: 20),
            tvShowCreatedBy.trailingAnchor.constraint(equalTo: mainBackVIew.trailingAnchor, constant: -20),
            
            //lastSeasonTitle
            
            lastSeasonTitle.topAnchor.constraint(equalTo: tvShowCreatedBy.bottomAnchor, constant: 32),
            lastSeasonTitle.leadingAnchor.constraint(equalTo: mainBackVIew.leadingAnchor, constant: 24),
            
            //lastSeasonImage
            
            lastSeasonImage.topAnchor.constraint(equalTo: lastSeasonTitle.bottomAnchor, constant: 20),
            lastSeasonImage.leadingAnchor.constraint(equalTo: mainBackVIew.leadingAnchor, constant: 20),
            lastSeasonImage.widthAnchor.constraint(equalToConstant: 130),
            lastSeasonImage.heightAnchor.constraint(equalToConstant: 183),
            
            //lastSeasonName
            
            lastSeasonName.topAnchor.constraint(equalTo: tvShowCreatedBy.bottomAnchor, constant: 115),
            lastSeasonName.leadingAnchor.constraint(equalTo: lastSeasonImage.trailingAnchor, constant: 32),
            lastSeasonName.trailingAnchor.constraint(equalTo: mainBackVIew.trailingAnchor, constant: -20),
            
            //lastSeasonReleaseDate
            
            lastSeasonReleaseDate.topAnchor.constraint(equalTo: lastSeasonName.bottomAnchor, constant: 8),
            lastSeasonReleaseDate.leadingAnchor.constraint(equalTo: lastSeasonImage.trailingAnchor, constant: 32),
            lastSeasonReleaseDate.trailingAnchor.constraint(equalTo: mainBackVIew.trailingAnchor, constant: -20),
            
            //viewAllSeasonButton
            
            viewAllSeasonButton.topAnchor.constraint(equalTo: lastSeasonReleaseDate.bottomAnchor, constant: 10),
            viewAllSeasonButton.leadingAnchor.constraint(equalTo: lastSeasonImage.trailingAnchor, constant: 32),
            viewAllSeasonButton.trailingAnchor.constraint(equalTo: mainBackVIew.trailingAnchor, constant: -20),
            viewAllSeasonButton.heightAnchor.constraint(equalToConstant: 30),
            
            //castTitle
            
            castTitle.topAnchor.constraint(equalTo: lastSeasonImage.bottomAnchor, constant: 40),
            castTitle.leadingAnchor.constraint(equalTo: mainBackVIew.leadingAnchor, constant: 20),
            castTitle.trailingAnchor.constraint(equalTo: mainBackVIew.trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: castTitle.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: mainBackVIew.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: mainBackVIew.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: mainBackVIew.bottomAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        let contentViewHeightConstraint = contentView.heightAnchor.constraint(
            equalTo: scrollView.heightAnchor
        )
        contentViewHeightConstraint.priority = .defaultLow
        contentViewHeightConstraint.isActive = true
    }
    
}

