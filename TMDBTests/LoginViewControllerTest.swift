//
//  LoginViewControllerTest.swift
//  TMDBTests
//
//  Created by Byron Chavarría on 30/12/20.
//

import XCTest

class LoginViewControllerTest: XCTestCase {

    func testHandleLoginSelection() {
        let validUsername = "bchavarria"
        let validPassword = "Pa55word"
        let loginController = LoginViewController()
        let viewModel = LoginViewModel(authService: AuthService())
        loginController.viewModel = viewModel
        viewModel.username.accept(validUsername)
        viewModel.password.accept(validPassword)
        let button = UIButton()
        let exp = expectation(description: "loading token")
        loginController.handleLogInSelection(button)
        exp.fulfill()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testInvalidLogin() {
        let validUsername = ""
        let validPassword = ""
        let loginController = LoginViewController()
        let viewModel = LoginViewModel(authService: AuthService())
        loginController.viewModel = viewModel
        viewModel.username.accept(validUsername)
        viewModel.password.accept(validPassword)
        let button = UIButton()
        XCTAssertNoThrow(loginController.handleLogInSelection(button))
    }
    
    func testKeyboardWillChange() {
        let loginController = LoginViewController()
        let viewModel = LoginViewModel(authService: AuthService())
        loginController.viewModel = viewModel
        let notification = Notification(name: UIResponder.keyboardDidShowNotification)
        XCTAssertNoThrow(loginController.keyboardWillChange(notification))
    }
    
    func testKeyboardWillChangeToHide() {
        let loginController = LoginViewController()
        let viewModel = LoginViewModel(authService: AuthService())
        loginController.viewModel = viewModel
        let notification = Notification(name: UIResponder.keyboardWillHideNotification)
        XCTAssertNoThrow(loginController.keyboardWillChange(notification))
    }
    
    func testKeyboardWillChangeWillShowNotification() {
        let loginController = LoginViewController()
        let viewModel = LoginViewModel(authService: AuthService())
        loginController.viewModel = viewModel
        let notification = Notification(name: UIResponder.keyboardWillShowNotification)
        XCTAssertNoThrow(loginController.keyboardWillChange(notification))
    }
    
    func testHideKeyboard() {
        let loginController = LoginViewController()
        let viewModel = LoginViewModel(authService: AuthService())
        loginController.viewModel = viewModel
        XCTAssertNoThrow(loginController.hideKeyboard())
    }
}
