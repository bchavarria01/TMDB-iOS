//
//  DefaultModelViewController.swift
//  TMDB
//
//  Created by Byron Chavarría on 3/1/21.
//

import UIKit

final class DefaultModelViewController: UIViewController {
    
    // MARK: - Components
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TMDB"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Attributes
    
    var actionableModal: ActionableModal!
    var handler: (() -> Void)? = nil
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.Colors.almostBlack.color
        setupLayout()
        setupAactions()
        setupActionButton()
        setupActionableModal()
    }
    
    // MARK: - Methods
    
    private func setupAactions() {
        actionButton.addTarget(self, action: #selector(self.handleAcrtionButtonSelection), for: .touchUpInside)
    }
    
    @objc func handleAcrtionButtonSelection() {
        self.dismiss(animated: true, completion: handler)
    }
    
    private func setupActionableModal() {
        titleLabel.text = actionableModal.title
        messageLabel.text = actionableModal.desctiption
        actionButton.setTitle(actionableModal.actionTitle, for: .normal)
    }
    
    private func setupActionButton() {
        actionButton.layer.cornerRadius = 18
        actionButton.layer.masksToBounds = true
        actionButton.titleLabel?.font = .systemFont(ofSize: 18)
        actionButton.backgroundColor = R.Colors.gray.color
        actionButton.tintColor = .white
    }
    
    private func setupLayout() {
        
        view.addSubview(titleLabel)
        view.addSubview(messageLabel)
        view.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            actionButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        ])
    }
    
}

