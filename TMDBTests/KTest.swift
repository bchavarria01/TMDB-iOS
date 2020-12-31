//
//  KTest.swift
//  TMDBTests
//
//  Created by Byron Chavarría on 30/12/20.
//

import XCTest

class KTest: XCTestCase {

    func testIsValidNavigationBarHeight() {
        let navigationBarHeight = K.Components.navigationBarHeight
        XCTAssertEqual(navigationBarHeight, 64)
    }

}
