//
//  HomeCoordinatorTest.swift
//  TMDBTests
//
//  Created by Byron Chavarría on 30/12/20.
//

import XCTest
import CoreData
@testable import TMDB

class HomeCoordinatorTest: XCTestCase {

    func testChieldCoordinator() {
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let nextPresenter = UINavigationController()
        let homeCoordinator = HomeCoordinator(
            presenter: nextPresenter,
            parentCoordinator: nil,
            context: context,
            isTest: true
        )
        let childsCount = homeCoordinator.childCoordinators.count
        XCTAssertEqual(0, childsCount)
    }
    
    func testStartHomeCoordinator() {
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let nextPresenter = UINavigationController()
        let homeCoordinator = HomeCoordinator(
            presenter: nextPresenter,
            parentCoordinator: nil,
            context: context,
            isTest: true
        )
        XCTAssertNoThrow(homeCoordinator.start())
    }
    
    func testEndCoordinator() {
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let nextPresenter = UINavigationController()
        let homeCoordinator = HomeCoordinator(
            presenter: nextPresenter,
            parentCoordinator: nil,
            context: context,
            isTest: true
        )
        XCTAssertNoThrow(homeCoordinator.endCoordinator())
    }

}
