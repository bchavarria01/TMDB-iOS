//
//  HomeViewControllerTest.swift
//  TMDBTests
//
//  Created by Byron Chavarría on 30/12/20.
//

import XCTest
import CoreData
@testable import TMDB

class HomeViewControllerTest: XCTestCase {

    func testHomeViewController() {
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let homeViewController = HomeViewController()
        let viewModel = HomeViewModel(tvShowService: TvShowsService(), context: context)
        homeViewController.viewModel = viewModel
        XCTAssertNoThrow(homeViewController.viewDidLoad())
    }
    
    func testHandleMenuSelection() {
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let homeViewController = HomeViewController()
        let viewModel = HomeViewModel(tvShowService: TvShowsService(), context: context)
        homeViewController.viewModel = viewModel
        homeViewController.viewDidLoad()
        XCTAssertNoThrow(homeViewController.handleMenuSelection())
    }
    
    func testDidSelectTvShow() {
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let homeViewController = HomeViewController()
        let viewModel = HomeViewModel(tvShowService: TvShowsService(), context: context)
        homeViewController.viewModel = viewModel
        homeViewController.viewDidLoad()
        XCTAssertNoThrow(homeViewController.showAlert(title: "", message: "", handler: nil))
    }

}
