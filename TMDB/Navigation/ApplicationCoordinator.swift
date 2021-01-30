//
//  ApplicationCoordinator.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//

import UIKit
import CoreData
import UIWindowTransitions

final class ApplicationCoordinator: Coordinator {
            
    // MARK: - Attributes
    
    let window: UIWindow
    var presenter: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    var context: NSManagedObjectContext!
    var isTest: Bool
    
    // MARK: - LifeCycle
    
    init(window: UIWindow,
         context: NSManagedObjectContext,
         isTest: Bool) {
        self.window = window
        self.context = context
        self.isTest = isTest
        presenter = UINavigationController()
        presenter.navigationBar.isHidden = true
        window.rootViewController = presenter
    }
    
    // MARK: Start
    
    func start() {
        var localSession: [Session] = []
        let request = Session.fetchRequest() as NSFetchRequest<Session>
        do {
             localSession = try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if localSession.count > 0 {
            var storedDate: Date?
            if let date = dateFormatterGet.date(from: localSession[0].expDate?.replacingOccurrences(of: " UTC", with: "") ?? "") {
                storedDate = date
            } else {
               print("There was an error decoding the string")
            }
            
            let startDate = Date()
            let currentDate = startDate.addingTimeInterval(6*60*60)
            
            if storedDate ?? Date() > currentDate {
                setupHomeCoordinator()
            } else {
                setupAuthCoordinator()
            }
        } else {
            setupAuthCoordinator()
        }
        
        #if DEBUG
            DeviceLogger.debug("Navigation start")
        #endif
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
            parentCoordinator: self,
            context: context,
            isTest: isTest
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
            parentCoordinator: self,
            context: context
        )
        
        let viewModel = HomeViewModel(tvShowService: TvShowsService(), authService: AuthService(), accountService: AccountService(), context: context, isTest: false)
        viewModel.deleteSession()
        
        authenticationCoordinator.start()
        
        var options = UIWindow.TransitionOptions()
        options.direction = .toLeft
        options.duration = 0.4
        options.style = .easeOut
        
        window.setRootViewController(authenticationCoordinator.presenter, options: options)
        addChildCoordinator(authenticationCoordinator)
    }
    
}

