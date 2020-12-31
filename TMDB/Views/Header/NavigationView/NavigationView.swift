//
//  NavigationView.swift
//  TMDB
//
//  Created by Byron Chavarría on 30/12/20.
//

import UIKit

final class NavigationView: UIView {
    
    // MARK: - Components
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString.attributedString(
            L10n.homeTitle,
            font: .systemFont(ofSize: 17),
            color: .white
        )
        label.attributedText = attributedText
        return label
    }()
    
    lazy var menuButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "list.bullet")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    
    // MARK: - Attributes
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = R.Colors.dark.color
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Methods
    
    private func setupLayout() {
        addSubview(titleLabel)
        addSubview(menuButton)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            menuButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            menuButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
