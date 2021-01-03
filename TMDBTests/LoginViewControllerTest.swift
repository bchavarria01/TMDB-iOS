//
//  LoginViewControllerTest.swift
//  TMDBTests
//
//  Created by Byron Chavarría on 30/12/20.
//

import XCTest
import CoreData
@testable import TMDB

class LoginViewControllerTest: XCTestCase {
    
    func testHandleLoginSelection() {
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let validUsername = "Bchavarria"
        let validPassword = "Pa55word"
        let loginController = LoginViewController()
        let viewModel = LoginViewModel(authService: AuthService(), context: context)
        loginController.viewModel = viewModel
        viewModel.username.accept(validUsername)
        viewModel.password.accept(validPassword)
        let button = UIButton()
        XCTAssertNoThrow(loginController.handleLogInSelection(button))
    }
    
    func testInvalidLogin() {
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let validUsername = ""
        let validPassword = ""
        let loginController = LoginViewController()
        let viewModel = LoginViewModel(authService: AuthService(), context: context)
        loginController.viewModel = viewModel
        viewModel.username.accept(validUsername)
        viewModel.password.accept(validPassword)
        let button = UIButton()
        XCTAssertNoThrow(loginController.handleLogInSelection(button))
    }
    
    func testKeyboardWillChange() {
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let loginController = LoginViewController()
        let viewModel = LoginViewModel(authService: AuthService(), context: context)
        loginController.viewModel = viewModel
        let notification = Notification(name: UIResponder.keyboardDidShowNotification)
        XCTAssertNoThrow(loginController.keyboardWillChange(notification))
    }
    
    func testKeyboardWillChangeToHide() {
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let loginController = LoginViewController()
        let viewModel = LoginViewModel(authService: AuthService(), context: context)
        loginController.viewModel = viewModel
        let notification = Notification(name: UIResponder.keyboardWillHideNotification)
        XCTAssertNoThrow(loginController.keyboardWillChange(notification))
    }
    
    func testKeyboardWillChangeWillShowNotification() {
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let loginController = LoginViewController()
        let viewModel = LoginViewModel(authService: AuthService(), context: context)
        loginController.viewModel = viewModel
        let notification = Notification(name: UIResponder.keyboardWillShowNotification)
        XCTAssertNoThrow(loginController.keyboardWillChange(notification))
    }
    
    func testHideKeyboard() {
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let loginController = LoginViewController()
        let viewModel = LoginViewModel(authService: AuthService(), context: context)
        loginController.viewModel = viewModel
        XCTAssertNoThrow(loginController.hideKeyboard())
    }
}
