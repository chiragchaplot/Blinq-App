//
//  HomeViewModelTest.swift
//  Blinq-AppTests
//
//  Created by Chirag Chaplot on 12/8/21.
//

import XCTest
@testable import Blinq_App

class HomeViewModelTest: XCTestCase {

    var homeViewModel = HomeViewModel()
    let defaults = UserDefaults.standard
    
    func test_IdealSubmission() {
        let param = ["name":"Chirag","email":"chiragchaplot@gmail.com"]
        var result = ResponseModel(errorMessage: "")
        let expection = self.expectation(description: "Post Data")
        
        homeViewModel.submitInvitation(param: param, completion: {
            (response, error) in
            
            if let response = response {
                result = response
                expection.fulfill()
            }
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(result.errorMessage,"Registered")
    }
    
    func test_NoNameSubmission() {
        let param = ["name":"","email":"chiragchaplot@gmail.com"]
        
        let expection = self.expectation(description: "Post Data")
        
        homeViewModel.submitInvitation(param: param, completion: {
            (response, error) in
            if let _ = error {
                expection.fulfill()
            }
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(defaults.value(forKey: "error") as! String ,"No name provided")
    }
    
    func test_NoEmailSubmission() {
        let param = ["name":"","email":""]
        let expection = self.expectation(description: "Post Data")
        
        homeViewModel.submitInvitation(param: param, completion: {
            (response, error) in
            if let _ = error {
                expection.fulfill()
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(defaults.value(forKey: "error") as! String ,"No email provided")
    }
    
    func test_InvalidEmail() {
        let param = ["name":"Chirag","email":"chirag@@gmail.com.au.india.bahrain.usa/dummyValue"]
        var result = ResponseModel(errorMessage: "")
        let expection = self.expectation(description: "Post Data")
        
        homeViewModel.submitInvitation(param: param, completion: {
            (response, error) in
            
            if let response = response {
                result = response
                expection.fulfill()
            }
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(result.errorMessage,"Registered")
    }
    

}
