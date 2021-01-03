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
        detailViewController.bindViewModel()
        XCTAssertNoThrow(detailViewController.viewDidLoad())
    }
    
    func testInvalidDataDetailViewController() {
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let detailViewController = DetailViewController()
        let viewModel = DetailViewModel(tvShowService: TvShowsService(), context: context)
        detailViewController.viewModel = viewModel
        detailViewController.tvId = 0
        detailViewController.bindViewModel()
        XCTAssertNoThrow(detailViewController.viewDidLoad())
    }
}
