//
//  itunesReaderTests.swift
//  itunesReaderTests
//
//  Created by Shyam Parmar on 06/05/18.
//  Copyright © 2018 FreeWare. All rights reserved.
//

import XCTest
@testable import itunesReader

class itunesReaderTests: XCTestCase {
  let viewModel = AppListViewModel()
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    let fetchListExpect = expectation(description: "Fetch List")

    viewModel.requestData(success: {
      fetchListExpect.fulfill()
    }) { (errorTitle, ErrorString) in
      fetchListExpect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
    
    let indexPath = IndexPath(row: 1, section: 0)
    let appDescription =  viewModel.appDescription(for: indexPath)
    XCTAssertNotNil(appDescription, "AppDescription not found")
    
    let appName = viewModel.appName(for: indexPath)
    XCTAssertNotNil(appName, "appname not found")

    
  }
  func testResult() {
    let failureResult = Result<Any>.failure(AppError.create("check for result"))
    
    XCTAssertFalse(failureResult.isSuccess)
    XCTAssertNil(failureResult.value, "Error: Value should be nil")
    XCTAssertNotNil(failureResult.error, "Error: error should not be nil.")
    
    let value = "Result String"
    let successResult = Result<String>.success(value)
    XCTAssertTrue(successResult.isSuccess)
    XCTAssertNotNil(successResult.value, "Error: Value should not be nil")
    XCTAssertNil(successResult.error, "Error: error should be nil.")
  }
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
