//
//  HomeViewControllerTests.swift
//  Blinq-AppTests
//
//  Created by Chirag Chaplot on 12/8/21.
//

import XCTest
@testable import Blinq_App

class HomeViewControllerTests: XCTestCase {

    var homeVC = HomeViewController()
    
    func test_emailValid(){
        XCTAssertFalse(homeVC.isValidEmail(email: "chirag@@gmail.com.au.india.bahrain.usa/dummyValue"))
        XCTAssertFalse(homeVC.isValidEmail(email: "chirag"))
        XCTAssertFalse(homeVC.isValidEmail(email: ""))
        XCTAssertFalse(homeVC.isValidEmail(email: "c@c"))
        XCTAssertTrue(homeVC.isValidEmail(email: "chiragchaplot@gmail.com"))
    }
    
    

}
