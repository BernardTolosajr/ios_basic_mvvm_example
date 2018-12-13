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
import RxSwift

@testable import basicmvvm

class basicmvvmTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
  
  // example of testing the dependency interface only.
  func testSubmitWillPassTheCorrectUserAsParameter() {
      // passing the initial model to stubs
      let user = User(username: "", password: "")
      let stub = StubApiManager(user: user, successValue: true)
    
      // setup the stub
      let viewModel = ViewModel(apiManager: stub)
      
      viewModel.username.value = "foo"
      viewModel.password.value = "bar"
      
      viewModel.submit()
    
      // asserting we pass the correct parameter
      XCTAssertTrue(viewModel.isSuccess.value)
      XCTAssertEqual(stub.user?.password, "bar")
      XCTAssertEqual(stub.user?.username, "foo")
  }
}

class StubApiManager: APIManagerProtocol {
  var successValue: Bool
  var user: User?
  
  init(user: User, successValue: Bool) {
    self.user = user
    self.successValue = successValue
  }
  
  func SignIn(_ user: User) -> Single<Bool> {
    self.user = user
    return Single<Bool>.create { single in
      single(.success(self.successValue))
      return Disposables.create()
    }
  }
}
