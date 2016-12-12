//
//  LoginPresenterTests.swift
//  NetworkTest
//
//  Created by Serkan Doğantekin on 12/12/2016.
//  Copyright © 2016 Serkan Doğantekin. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import NetworkTest

class LoginPresenterTests: XCTestCase {
    var loginControllerMock:LoginControllerMock!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        loginControllerMock = LoginControllerMock()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let presenter = LoginPresenter(loginControllerMock)
        presenter.loginService = LoginServiceMock()
        presenter.login(username: "test", password: "test")
        XCTAssertTrue(loginControllerMock.showMessageCalled, "message should be displayed")
    }    
}

class LoginServiceMock:LoginServiceProtocol {
    func login(username:String, password:String, completion:@escaping (LoginResponse?, Error?) -> Void) throws {
        let response = LoginResponse(map: Map(mappingType: MappingType.fromJSON, JSON: ["":""]))
        response!.userId = "serkan"
        response!.lastLogin = Date()
        response!.age = 30
        completion(response,nil)
    }
}

class LoginControllerMock:LoginControllerProtocol {
    var showMessageCalled = false
    
    func showMessage(title:String, message:String) {
        showMessageCalled = true
    }
}
