//
//  ApplicationCoordinator.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//

import UIKit
import UIWindowTransitions

final class ApplicationCoordinator: Coordinator {
            
    // MARK: - Attributes
    
    let window: UIWindow
    var presenter: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    // MARK: - LifeCycle
    
    init(window: UIWindow) {
        self.window = window
        presenter = UINavigationController()
        presenter.navigationBar.isHidden = true
        window.rootViewController = presenter
    }
    
    // MARK: Start
    
    func start() {
        let authenticationCoordinator = AuthenticationCoordinator(
            presenter: presenter,
            parentCoordinator: self
        )
        authenticationCoordinator.start()
        window.makeKeyAndVisible()
        
        #if DEBUG
            DeviceLogger.debug("Navigation start")
        #endif
        
        addChildCoordinator(authenticationCoordinator)
    }
    
    func end(with step: AppStep) {
        switch step {
        case .home:
            presenter.popToRootViewController(animated: true)
            
        case .auth:
            setupAuthCoordinator()
        }
    }
    
    func setupHomeCoordinator() {
        let nextPresenter = UINavigationController()
        let homeCoordinator = HomeCoordinator(
            presenter: nextPresenter,
            parentCoordinator: self
        )
        homeCoordinator.start()
        
        var options = UIWindow.TransitionOptions()
        options.direction = .toRight
        options.duration = 0.4
        options.style = .easeIn
        
        window.setRootViewController(homeCoordinator.presenter, options: options)
        addChildCoordinator(homeCoordinator)
    }
    
    func setupAuthCoordinator() {
        let nextPresenter = UINavigationController()
        let authenticationCoordinator = AuthenticationCoordinator(
            presenter: nextPresenter,
            parentCoordinator: self
        )
        
        authenticationCoordinator.start()
        
        var options = UIWindow.TransitionOptions()
        options.direction = .toLeft
        options.duration = 0.4
        options.style = .easeOut
        
        window.setRootViewController(authenticationCoordinator.presenter, options: options)
        addChildCoordinator(authenticationCoordinator)
    }
    
}

