//
//  ApplicationCoordinatorTest.swift
//  TMDBTests
//
//  Created by Byron Chavarría on 2/1/21.
//

import UIKit
import XCTest
import CoreData
@testable import TMDB

class ApplicationCoordinatorTest: XCTestCase {

    func testApplicactionCoordinator() {
        let winwdow = UIWindow()
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let appCoordinator = ApplicationCoordinator(window: winwdow, context: context)
        XCTAssertNoThrow(appCoordinator.setupHomeCoordinator())
    }
    
    func testEndCoordinatorWithAuth() {
        let winwdow = UIWindow()
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let appCoordinator = ApplicationCoordinator(window: winwdow, context: context)
        appCoordinator.setupHomeCoordinator()
        XCTAssertNoThrow(appCoordinator.end(with: .auth))
    }
    
    func testEndCoordinatorWithHome() {
        let winwdow = UIWindow()
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let appCoordinator = ApplicationCoordinator(window: winwdow, context: context)
        appCoordinator.setupAuthCoordinator()
        XCTAssertNoThrow(appCoordinator.end(with: .home))
    }

}
