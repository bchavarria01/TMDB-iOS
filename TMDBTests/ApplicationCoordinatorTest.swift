//
//  ApplicationCoordinatorTest.swift
//  TMDBTests
//
//  Created by Byron Chavarría on 30/12/20.
//

import XCTest

class ApplicationCoordinatorTest: XCTestCase {

    func testEndApplicacionCoordinator() {
        let window = UIWindow()
        let appCoordinator = ApplicationCoordinator(window: window)
        XCTAssertNoThrow(appCoordinator.end(with: .home))
        XCTAssertNoThrow(appCoordinator.end(with: .auth))
    }
    
    func testSetUpHomeCoordinator() {
        let window = UIWindow()
        let appCoordinator = ApplicationCoordinator(window: window)
        XCTAssertNoThrow(appCoordinator.setupHomeCoordinator())
    }

}
