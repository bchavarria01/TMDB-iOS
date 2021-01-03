//
//  SeasonsViewControllerTest.swift
//  TMDBTests
//
//  Created by Byron Chavarría on 2/1/21.
//

import XCTest
import CoreData
@testable import TMDB

class SeasonsViewControllerTest: XCTestCase {

    func testSeasonsViewController() {
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let controller = SeasonsViewController()
        let viewModel = SeasonsViewModel(tvShowService: TvShowsService(), context: context)
        controller.viewModel = viewModel
        XCTAssertNoThrow(controller.viewDidLoad())
        DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
            XCTAssertNoThrow(controller.bindViewModel())
        })
        
    }
    
}
