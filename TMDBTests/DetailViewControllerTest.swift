//
//  DetailViewControllerTest.swift
//  TMDBTests
//
//  Created by Byron Chavarría on 30/12/20.
//

import XCTest
import CoreData
@testable import TMDB

class DetailViewControllerTest: XCTestCase {
    
    func testDetailViewController() {
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let detailViewController = DetailViewController()
        let viewModel = DetailViewModel(tvShowService: TvShowsService(), context: context)
        detailViewController.viewModel = viewModel
        detailViewController.tvId = 107124
        let expectation = self.expectation(description: "")
        detailViewController.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 6, handler: nil)
    }
    
    func testDataDetailViewController() {
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let detailViewController = DetailViewController()
        let viewModel = DetailViewModel(tvShowService: TvShowsService(), context: context)
        detailViewController.viewModel = viewModel
        detailViewController.tvId = 107124
        let expectation = self.expectation(description: "")
        detailViewController.viewDidAppear(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
}
