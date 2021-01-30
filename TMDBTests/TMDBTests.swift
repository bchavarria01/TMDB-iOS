//
//  TMDBTests.swift
//  TMDBTests
//
//  Created by Byron Chavarría on 28/12/20.
//

import XCTest
@testable import TMDB

class TMDBTests: XCTestCase {

    func testExample() throws {
        // This is an example of a functional test case.
        let controller = UIViewController()
        controller.didSelectTvShow(with: 1)
        controller.didSelectNextPage()
        
        let service = AccountService()
        _ = service.getAccountInfo(with: "")
        _ = service.markAsFavorite(with: 0, and: true, userId: "", and: "")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
