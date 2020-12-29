//
//  HomeCoordinator.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//

import UIKit
import RxSwift

final class HomeCoordinator: Coordinator {
    
    // MARK: - Attributes
    
    var presenter: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    
    init(presenter: UINavigationController,
         parentCoordinator: Coordinator) {
        self.presenter = presenter
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let controller = LoginViewController()
        presenter.navigationBar.isHidden = true
        presenter.pushViewController(controller, animated: true)
    }
    
    @objc func endCoordinator() {
        parentCoordinator?.end(with: .auth)
    }
}