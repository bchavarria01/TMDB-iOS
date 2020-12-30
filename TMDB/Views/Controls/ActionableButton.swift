//
//  ActionableButton.swift
//  TMDB
//
//  Created by Byron Chavarría on 29/12/20.
//

import UIKit

final class ActionableButton: UIButton {
    
    // MARK: - Components
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
       let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    // MARK: - Attributes
    
    var actionType: Int = 1 {
        willSet {
            setup()
        }
    }
    
    var isAnimating: Bool {
        return activityIndicator.isAnimating
    }
    
    func startAnimating() {
        isEnabled = false
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        isEnabled = true
        activityIndicator.stopAnimating()
    }
    
    
    
    // MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Helpers
    
    private func addActivityIndicator() {
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setup() {
        addActivityIndicator()
    }
}

