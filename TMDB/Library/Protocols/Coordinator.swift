//
//  Coordinator.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import UIKit

protocol Coordinator: AnyObject {
    var presenter: UINavigationController { get }
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
     
    func start()
    
    func end(with step: AppStep)
    
    func childDidFinish(_ child: Coordinator?)
    func addChildCoordinator(_ coordinator: Coordinator)
}

extension Coordinator {
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }

    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func end(with step: AppStep) {
        parentCoordinator?.end(with: step)
        parentCoordinator?.childDidFinish(self)
    }
}
