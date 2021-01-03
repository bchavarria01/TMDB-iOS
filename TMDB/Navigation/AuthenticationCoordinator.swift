//
//  AuthenticationCoordinator.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//

import UIKit
import CoreData
import LocalAuthentication
import UIWindowTransitions

final class AuthenticationCoordinator: Coordinator {
    
    // MARK: - Attributes
    
    let presenter: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    var context: NSManagedObjectContext!
    
    // MARK: - LifeCycle
    
    init(presenter: UINavigationController,
         parentCoordinator: Coordinator,
         context: NSManagedObjectContext) {
        self.presenter = presenter
        self.parentCoordinator = parentCoordinator
        self.context = context
    }
    
    // MARK: - Start
    
    func start() {
        presenter.navigationBar.isHidden = true
        presentLoginViewController()
    }
    
    func presentLoginViewController() {
        let loginViewController = LoginViewController()
        loginViewController.delegate = self
        let viewModel = LoginViewModel(authService: AuthService(), context: context)
        loginViewController.viewModel = viewModel
        presenter.pushViewController(loginViewController, animated: true)
    }
}

extension AuthenticationCoordinator: LoginViewControllerDelegate {
    func loginViewControllerDidLogInSuccessfully() {
        guard let parent = parentCoordinator as? ApplicationCoordinator else { return }
        parent.setupHomeCoordinator()
    }
}

