//
//  DetailViewController.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//

import UIKit

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
        imageView.image = R.Base.banner.image
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
        view.backgroundColor = R.Colors.dark.color
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
        let attributedText = NSMutableAttributedString.attributedString("Rick and Morty", font: .systemFont(ofSize: 18), color: .white)
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
        let attributedText = NSMutableAttributedString.attributedString(L10n.exampleText, font: .systemFont(ofSize: 12), color: .white)
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
        imageView.image = R.Base.interstellar.image
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
        return button
    }()
    
    lazy var castTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString.attributedString(L10n.cast, font: .boldSystemFont(ofSize: 18), color: R.Colors.green.color)
        label.attributedText = attributedText
        return label
    }()
    
    // MARK: - Attributes
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.Colors.almostBlack.color
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        
        setupMainBackView()
        setupLayout()
    }
    
    // MARK: - Methods
    
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
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(tvShowImage)
        contentView.addSubview(mainBackVIew)
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: -32),
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
            
            mainBackVIew.topAnchor.constraint(equalTo: tvShowImage.bottomAnchor, constant: -56),
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
            lastSeasonImage.widthAnchor.constraint(equalTo: mainBackVIew.widthAnchor, multiplier: 0.4030769231),
            lastSeasonImage.heightAnchor.constraint(equalToConstant: 183),
            
            //lastSeasonName
            
            lastSeasonName.topAnchor.constraint(equalTo: tvShowCreatedBy.bottomAnchor, constant: 115),
            lastSeasonName.leadingAnchor.constraint(equalTo: lastSeasonImage.trailingAnchor, constant: 32),
            lastSeasonName.trailingAnchor.constraint(equalTo: mainBackVIew.trailingAnchor, constant: 20),
            
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
            castTitle.trailingAnchor.constraint(equalTo: mainBackVIew.trailingAnchor, constant: -20)
        ])
        
        let contentViewHeightConstraint = contentView.heightAnchor.constraint(
            equalTo: scrollView.heightAnchor
        )
        contentViewHeightConstraint.priority = .defaultLow
        contentViewHeightConstraint.isActive = true
    }
    
}

