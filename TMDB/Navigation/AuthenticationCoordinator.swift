//
//  AuthenticationCoordinator.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//

import UIKit
import LocalAuthentication
import UIWindowTransitions

final class AuthenticationCoordinator: Coordinator {
    
    // MARK: - Attributes
    
    let presenter: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    // MARK: - LifeCycle
    
    init(presenter: UINavigationController,
         parentCoordinator: Coordinator) {
        self.presenter = presenter
        self.parentCoordinator = parentCoordinator
    }
    
    // MARK: - Start
    
    func start() {
        presenter.navigationBar.isHidden = true
        presentLoginViewController()
    }
    
    func presentLoginViewController() {
        let loginViewController = LoginViewController()
        loginViewController.delegate = self
        presenter.pushViewController(loginViewController, animated: true)
    }
}

extension AuthenticationCoordinator: LoginViewControllerDelegate {
    func loginViewControllerDidLogInSuccessfully() {
        let controller = HomeViewController()
        presenter.pushViewController(controller, animated: true)
    }
}
