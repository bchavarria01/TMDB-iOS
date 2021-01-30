//
//  LoginViewController.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//

import UIKit
import RxSwift
import Moya

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
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.textColor = .gray
        textField.attributedPlaceholder = NSAttributedString(
            string: L10n.usernamePlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.tag = 0
        return textField
    }()
    
    lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.placeholder = L10n.passwordPlaceholder
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.textColor = .gray
        textField.attributedPlaceholder = NSAttributedString(
            string: L10n.passwordPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.tag = 1
        return textField
    }()
    
    lazy var logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.layer.cornerRadius = 5
        button.backgroundColor = R.Colors.gray.color
        button.setTitle(L10n.loginAction, for: .normal)
        return button
    }()
    
    // MARK: - Attributes
    
    weak var delegate: LoginViewControllerDelegate?
    var viewModel: LoginViewModel!
    let disposeBag = DisposeBag()
    
    var usernameHasValue: Bool = false
    var passwordHasValue: Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.Colors.almostBlack.color
        getToken()
        setupLayout()
        setupActions()
        bindViewModel()
        hideKeyboardGesture()
        setupKeyboardHandling()
    }
    
    // MARK: - Methods
    
    func bindViewModel() {
        usernameTextField
            .rx
            .value
            .bind(to: viewModel.username)
            .disposed(by: disposeBag)
        
        passwordField
            .rx
            .value
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
    }
    
    private func setupActions() {
        logInButton.addTarget(
            self,
            action: #selector(self.handleLogInSelection(_:)),
            for: .touchUpInside
        )
        
        usernameTextField.addTarget(
            self,
            action: #selector(self.textFieldDidChange(_:)),
            for: .editingChanged
        )
        
        passwordField.addTarget(
            self,
            action: #selector(self.textFieldDidChange(_:)),
            for: .editingChanged
        )
    }
    
    func getToken() {
        showLoading()
        viewModel.getToken()
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                self.dismiss(animated: true, completion: nil)
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.dismiss(animated: true, completion: {
                    self.handleError(error)
                })
            }
        ).disposed(by: disposeBag)
    }
    
    @objc func handleLogInSelection(_ sender: UIButton) {
        sender.isEnabled = false
        showLoading()
        viewModel.authenticateWithCredentials()
            .subscribe(
                onSuccess: { [weak self] response in
                    guard let self = self else { return }
                    self.dismiss(animated: true, completion: {
                        sender.isEnabled = true
                        if response.success ?? false {
                            self.delegate?.loginViewControllerDidLogInSuccessfully()
                        } else {
                            self.handleOperationResult(type: .exception(description: response.message ?? ""))
                        }
                    })
                }, onError: { [weak self] error in
                    guard let self = self else { return }
                    self.dismiss(animated: true, completion: {
                        sender.isEnabled = true
                        self.handleError(error)
                    })
                }
            ).disposed(by: disposeBag)
    }
    
    private func setupKeyboardHandling() {
        subscribeForKeyboardChange(
            self,
            selector: #selector(keyboardWillChange(_:))
        )
    }
    
    @objc func keyboardWillChange(_ notification: Notification) {
        
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            else { return }
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else if notification.name == UIResponder.keyboardWillShowNotification {
            scrollView.contentInset.bottom = frame.height
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.tag == 0 {
            usernameHasValue = textField.text != ""
        } else if textField.tag == 1 {
            passwordHasValue = textField.text != ""
        }
        
        if usernameHasValue && passwordHasValue {
            logInButton.backgroundColor = R.Colors.green.color
            logInButton.isEnabled = true
        } else {
            logInButton.backgroundColor = R.Colors.gray.color
            logInButton.isEnabled = false
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
