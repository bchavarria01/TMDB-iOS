//
//  SourceValidationsTest.swift
//  TMDBTests
//
//  Created by Byron Chavarría on 30/12/20.
//

import XCTest

class SourceValidationsTest: XCTestCase {

    func testValidEmail() {
        let isValidEmail = SourceValidations.isValidEmail("mail@server.com")
        XCTAssertTrue(isValidEmail)
    }
    
    func testInvalidEmail() {
        let isValidEmail = SourceValidations.isValidEmail("mail@server")
        XCTAssertFalse(isValidEmail)
    }
    
    func testOnlyNumbers() {
        let onlyNumbers = SourceValidations.onlyNumbers("123455")
        XCTAssertTrue(onlyNumbers)
    }
    
    func testNotOnlyNumbers() {
        let onlyNumbers = SourceValidations.onlyNumbers("sdaa212")
        XCTAssertFalse(onlyNumbers)
    }
    
    func testHasEqualLenght() {
        let hasEqualLenght = SourceValidations.hasEqualsLenght("123", lenght: 3)
        XCTAssertTrue(hasEqualLenght)
    }
    
    func testHasNotEqualLenght() {
        let hasEqualLenght = SourceValidations.hasEqualsLenght("1234", lenght: 3)
        XCTAssertFalse(hasEqualLenght)
    }
    
    func testHasValidLenght() {
        let hasValidLenght = SourceValidations.hasValidLenght("1234", maxLenght: 4, minLenght: 1)
        XCTAssertTrue(hasValidLenght)
    }
    
    func testHasNotValidLenght() {
        let hasValidLenght = SourceValidations.hasValidLenght("13455", maxLenght: 4, minLenght: 4)
        XCTAssertFalse(hasValidLenght)
    }
    
    func testIsSameString() {
        let isSameString = SourceValidations.isSameString("abc", secondSource: "abc")
        XCTAssertTrue(isSameString)
    }
    
    func testIsNotSameString() {
        let isSameString = SourceValidations.isSameString("abc", secondSource: "")
        XCTAssertFalse(isSameString)
    }

}
