//
//  basicmvvmTests.swift
//  basicmvvmTests
//
//  Created by Bernard tolosa on 13/12/2018.
//  Copyright © 2018 Mynt. All rights reserved.
//

import XCTest
import RxTest
import RxBlocking

@testable import basicmvvm

class basicmvvmTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testIsValidReturnTrue() {
      do{
        let viewModel = ViewModel()
        
        viewModel.password.value = "foo"
        viewModel.username.value = "bar"
        
        let result = try viewModel.isValid.toBlocking().first()
        XCTAssertTrue(result!)
      } catch {
        XCTFail(error.localizedDescription)
      }
    }

  func testIsValidReturnFalse() {
    do{
      let viewModel = ViewModel()
      
      viewModel.password.value = "foo"
      
      let result = try viewModel.isValid.toBlocking().first()
      XCTAssertFalse(result!)
    } catch {
      XCTFail(error.localizedDescription)
    }
  }
  
  func testSubmit() {
    do{
      let viewModel = ViewModel()
      
      viewModel.submit()
      
      XCTAssertTrue(viewModel.isSuccess.value)
    } catch {
      XCTFail(error.localizedDescription)
    }
  }
}
