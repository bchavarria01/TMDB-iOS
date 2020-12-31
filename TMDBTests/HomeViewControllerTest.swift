//
//  HomeViewControllerTest.swift
//  TMDBTests
//
//  Created by Byron Chavarría on 30/12/20.
//

import XCTest

class HomeViewControllerTest: XCTestCase {

    func testHomeViewController() {
        let homeViewController = HomeViewController()
        let viewModel = HomeViewModel(tvShowService: TvShowsService())
        homeViewController.viewModel = viewModel
        XCTAssertNoThrow(homeViewController.viewDidLoad())
    }
    
    func testHandleMenuSelection() {
        let homeViewController = HomeViewController()
        let viewModel = HomeViewModel(tvShowService: TvShowsService())
        homeViewController.viewModel = viewModel
        homeViewController.viewDidLoad()
        XCTAssertNoThrow(homeViewController.handleMenuSelection())
    }
    
    func testDidSelectTvShow() {
        let homeViewController = HomeViewController()
        let viewModel = HomeViewModel(tvShowService: TvShowsService())
        homeViewController.viewModel = viewModel
        homeViewController.viewDidLoad()
        XCTAssertNoThrow(homeViewController.didSelectTvShow(with: 0))
    }

}
