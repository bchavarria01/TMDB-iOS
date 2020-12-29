//
//  LoginViewController.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//

import UIKit

final class LoginViewController: UIViewController {
    
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
    
    lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = R.Base.logo.image
        return imageView
    }()
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = L10n.usernamePlaceholder
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.placeholder = L10n.passwordPlaceholder
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    lazy var logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = R.Colors.green.color
        button.layer.cornerRadius = 5
        button.setTitle(L10n.loginAction, for: .normal)
        return button
    }()
    
    // MARK: - Attributes
    
    weak var delegate: LoginViewControllerDelegate?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.Colors.almostBlack.color
        setupLayout()
        setupActions()
        hideKeyboardGesture()
        setupKeyboardHandling()
    }
    
    // MARK: - Methods
    
    private func setupActions() {
        logInButton.addTarget(
            self,
            action: #selector(self.handleLogInSelection(_:)),
            for: .touchUpInside
        )
    }
    
    @objc func handleLogInSelection(_ sender: UIButton) {
        delegate?.loginViewControllerDidLogInSuccessfully()
    }
    
    private func setupKeyboardHandling() {
        subscribeForKeyboardChange(
            self,
            selector: #selector(keyboardWillChange(_:))
        )
    }
    
    @objc private func keyboardWillChange(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            else { return }
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else if notification.name == UIResponder.keyboardWillShowNotification {
            scrollView.contentInset.bottom = frame.height
        }
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(logoImage)
        contentView.addSubview(usernameTextField)
        contentView.addSubview(passwordField)
        contentView.addSubview(logInButton)
        
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
            
            logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -56),
            logoImage.widthAnchor.constraint(equalToConstant: 144),
            logoImage.heightAnchor.constraint(equalToConstant: 128),
            
            usernameTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 80),
            usernameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 80),
            usernameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -80),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 80),
            passwordField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -80),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            
            logInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 80),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -80),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
        let contentViewHeightConstraint = contentView.heightAnchor.constraint(
            equalTo: scrollView.heightAnchor
        )
        contentViewHeightConstraint.priority = .defaultLow
        contentViewHeightConstraint.isActive = true
    }
    
}

