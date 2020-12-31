//
//  DetailViewControllerTest.swift
//  TMDBTests
//
//  Created by Byron Chavarría on 30/12/20.
//

import XCTest

class DetailViewControllerTest: XCTestCase {

    func testDetailViewController() {
        let detailViewController = DetailViewController()
        let viewModel = DetailViewModel(tvShowService: TvShowsService())
        detailViewController.viewModel = viewModel
        detailViewController.tvId = 107124
        detailViewController.bindViewModel()
        XCTAssertNoThrow(detailViewController.viewDidLoad())
    }
    
    func testInvalidDataDetailViewController() {
        let detailViewController = DetailViewController()
        let viewModel = DetailViewModel(tvShowService: TvShowsService())
        detailViewController.viewModel = viewModel
        detailViewController.tvId = 0
        detailViewController.bindViewModel()
        XCTAssertNoThrow(detailViewController.viewDidLoad())
    }
}
