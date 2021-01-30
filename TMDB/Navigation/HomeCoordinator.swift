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
    var isTest: Bool
    
    // MARK: - LifeCycle
    
    init(presenter: UINavigationController,
         parentCoordinator: Coordinator?,
         context: NSManagedObjectContext,
         isTest: Bool) {
        self.presenter = presenter
        self.parentCoordinator = parentCoordinator
        self.context = context
        self.isTest = isTest
    }
    
    func start() {
        let controller = HomeViewController()
        let viewModel = HomeViewModel(tvShowService: TvShowsService(), authService: AuthService(), accountService: AccountService(), context: context, isTest: isTest)
        controller.isFromLoginOrStart = true
        controller.viewModel = viewModel
        controller.delegate = self
        presenter.navigationBar.isHidden = true
        presenter.pushViewController(controller, animated: true)
    }
    
    @objc func endCoordinator() {
        parentCoordinator?.end(with: .auth)
    }
    
    func presentProfileViewController() {
        let controller = ProfileViewController()
        controller.modalPresentationStyle = .popover
        var localUserInfo: [UserInfo] = []
        
        let request2 = UserInfo.fetchRequest() as NSFetchRequest<UserInfo>
        do {
            localUserInfo = try self.context.fetch(request2)
        } catch {
            print(error.localizedDescription)
        }
        let userInfo = localUserInfo[0]
        let accountModel = AccountModel()
        accountModel.imageData = userInfo.imageData
        accountModel.imagePath = userInfo.imagePath
        accountModel.userId = userInfo.userId
        accountModel.username = userInfo.username
        controller.setupProfileInfo(with: accountModel)
        controller.viewModel = ProfileViewModel(accountService: AccountService(), context: context, isTest: isTest)
        presenter.present(controller, animated: true, completion: nil)
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
    func homeViewControllerDidSelectMenu() {
        // 1
        let optionMenu = UIAlertController(title: nil, message: L10n.optionsQustion, preferredStyle: .actionSheet)
        
        // 2
        let profileAction = UIAlertAction(title: L10n.profileTitle, style: .default) { (action) in
            self.presentProfileViewController()
        }
        
        // 3
        let logOutAvtion = UIAlertAction(title: L10n.logOut, style: .destructive) { (action) in
            self.endCoordinator()
        }
        
        // 4
        let cancelAction = UIAlertAction(title: L10n.cancelAction, style: .cancel)
        
        // 5
        optionMenu.addAction(profileAction)
        optionMenu.addAction(logOutAvtion)
        optionMenu.addAction(cancelAction)
        
        // 6
        presenter.present(optionMenu, animated: true, completion: nil)
        
    }
    
    func homeViewControllerDidSelectTvShow(with tvId: Int) {
        let controller = DetailViewController()
        controller.tvId = tvId
        let viewModel = DetailViewModel(tvShowService: TvShowsService(), accountService: AccountService(), context: context, isTest: isTest)
        controller.delegate = self
        controller.viewModel = viewModel
        presenter.pushViewController(controller, animated: true)
    }
}

extension HomeCoordinator: DetailViewControllerDelegate {
    
    func detailViewControllerDidSelectBack() {
        presenter.popViewController(animated: true)
    }
    
    func detialViewControllerDidSelectViewAllSeasons(wit tvId: Int, and numberOfSeasons: Int) {
        let controller = SeasonsViewController()
        controller.viewModel = SeasonsViewModel(tvShowService: TvShowsService(), context: context, isTest: isTest)
        controller.tvId = tvId
        controller.numberOfSeasons = numberOfSeasons
        controller.modalPresentationStyle = .popover
        presenter.present(controller, animated: true, completion: nil)
    }
}
