//
//  ProfileViewControllerTest.swift
//  TMDBTests
//
//  Created by Byron Chavarría on 30/1/21.
//

import XCTest
import CoreData
@testable import TMDB

class ProfileViewControllerTest: XCTestCase {

    func testCastCollectionCell() {
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let profileViewController = ProfileViewController()
        let viewModel = ProfileViewModel(accountService: AccountService(), context: context, isTest: true)
        profileViewController.viewModel = viewModel
        XCTAssertNoThrow(profileViewController.viewDidLoad())
    }

}
