//
//  LoginTest.swift
//  MeetingSchedulerTests
//

import XCTest
@testable import MeetingScheduler

class LoginTest: XCTestCase {
    
    var vcLogin: LoginVC!

    override func setUp() {
        super.setUp()
        vcLogin = LoginWireFrame.createLoginScreen()
        _ = vcLogin.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDataNilInLoginServiceEndToEnd() {
        
        vcLogin.emailField.text = "pritesh"
        vcLogin.passwordField.text = "poY7trl"
        vcLogin.loginButton.sendActions(for: .touchUpInside)
        guard let receivedError = actionDelegate.error as? LoginServiceError else {
            XCTFail("Expected error of type LoginFormValidationError but got \(actionDelegate.error)")
            return
        }
        XCTAssertTrue(actionDelegate.isHandleErrorCalled , "The function handleError is not called.")
        XCTAssert(receivedError == LoginServiceError.nilData, "The function handleError is called but the error received as the argument in the function is wrong, Expected the error of type \(LoginServiceError.nilData) but got \(receivedError)")
    }
}
