//
//  HomeCoordinator.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//

import UIKit
import RxSwift
import CoreData

final class HomeCoordinator: Coordinator {
    
    // MARK: - Attributes
    
    var presenter: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    let disposeBag = DisposeBag()
    let context: NSManagedObjectContext!
    
    // MARK: - LifeCycle
    
    init(presenter: UINavigationController,
         parentCoordinator: Coordinator?,
         context: NSManagedObjectContext) {
        self.presenter = presenter
        self.parentCoordinator = parentCoordinator
        self.context = context
    }
    
    func start() {
        let controller = HomeViewController()
        let viewModel = HomeViewModel(tvShowService: TvShowsService(), context: context)
        controller.viewModel = viewModel
        controller.delegate = self
        presenter.navigationBar.isHidden = true
        presenter.pushViewController(controller, animated: true)
    }
    
    @objc func endCoordinator() {
        parentCoordinator?.end(with: .auth)
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
    func homeViewControllerDidSelectMenu() {
        
    }
    
    func homeViewControllerDidSelectTvShow(with tvId: Int) {
        let controller = DetailViewController()
        controller.tvId = tvId
        let viewModel = DetailViewModel(tvShowService: TvShowsService(), context: context)
        controller.delegate = self
        controller.viewModel = viewModel
        presenter.pushViewController(controller, animated: true)
    }
}

extension HomeCoordinator: DetailViewControllerDelegate {
    func detialViewControllerDidSelectViewAllSeasons(wit tvId: Int, and numberOfSeasons: Int) {
        let controller = SeasonsViewController()
        controller.viewModel = SeasonsViewModel(tvShowService: TvShowsService(), context: context)
        controller.tvId = tvId
        controller.numberOfSeasons = numberOfSeasons
        controller.modalPresentationStyle = .popover
        presenter.present(controller, animated: true, completion: nil)
    }
}
