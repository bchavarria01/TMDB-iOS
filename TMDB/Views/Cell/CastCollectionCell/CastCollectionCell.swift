//
//  CastCollectionCell.swift
//  TMDB
//
//  Created by Byron Chavarría on 29/12/20.
//

import UIKit
import Reusable

class CastCollectionCell: UICollectionViewCell {
    
    // MARK: - Components
    
    lazy var actorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = R.Base.placeholder.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var actorName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString.attributedString("Actor 1", font: .systemFont(ofSize: 12), color: .white)
        label.attributedText = attributedText
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Attributes
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
        layer.setNeedsLayout()
        layer.layoutIfNeeded()
        
        actorImage.roundImage()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Methods
    
    private func setupLayout() {
        addSubview(actorImage)
        addSubview(actorName)
        
        NSLayoutConstraint.activate([
            actorImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            actorImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            actorImage.widthAnchor.constraint(equalToConstant: 100),
            actorImage.heightAnchor.constraint(equalToConstant: 100),
            
            
            actorName.topAnchor.constraint(equalTo: actorImage.bottomAnchor, constant: 4),
            actorName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            actorName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            actorName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
}
