//
//  LoginInteractorTests.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/12/19.
//  Copyright (c) 2019 Wing Sun Cheung. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Prodrivetime_ios
import XCTest

class LoginInteractorTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: LoginInteractor!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupLoginInteractor()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupLoginInteractor()
  {
    sut = LoginInteractor()
  }
  
  // MARK: Test doubles
  
  class LoginPresentationLogicSpy: LoginPresentationLogic
  {
    var presentSomethingCalled = false
    
    func presentSomething(response: Login.Something.Response)
    {
      presentSomethingCalled = true
    }
  }
  
  // MARK: Tests
  
  func testDoSomething()
  {
    // Given
    let spy = LoginPresentationLogicSpy()
    sut.presenter = spy
    let request = Login.Something.Request()
    
    // When
    sut.doSomething(request: request)
    
    // Then
    XCTAssertTrue(spy.presentSomethingCalled, "doSomething(request:) should ask the presenter to format the result")
  }
}
