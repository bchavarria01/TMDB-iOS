//
//  HomeCoordinatorTest.swift
//  TMDBTests
//
//  Created by Byron Chavarría on 30/12/20.
//

import XCTest

class HomeCoordinatorTest: XCTestCase {

    func testChieldCoordinator() {
        let nextPresenter = UINavigationController()
        let homeCoordinator = HomeCoordinator(
            presenter: nextPresenter,
            parentCoordinator: nil
        )
        let childsCount = homeCoordinator.childCoordinators.count
        XCTAssertEqual(0, childsCount)
    }
    
    func testStartHomeCoordinator() {
        let nextPresenter = UINavigationController()
        let homeCoordinator = HomeCoordinator(
            presenter: nextPresenter,
            parentCoordinator: nil
        )
        XCTAssertNoThrow(homeCoordinator.start())
    }
    
    func testEndCoordinator() {
        let nextPresenter = UINavigationController()
        let homeCoordinator = HomeCoordinator(
            presenter: nextPresenter,
            parentCoordinator: nil
        )
        XCTAssertNoThrow(homeCoordinator.endCoordinator())
    }

}
