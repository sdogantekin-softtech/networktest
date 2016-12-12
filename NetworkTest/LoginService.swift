//
//  LoginService.swift
//  NetworkTest
//
//  Created by Serkan Doğantekin
//  Copyright © 2016 Serkan Doğantekin. All rights reserved.
//

import ObjectMapper

class LoginService:BaseService, LoginServiceProtocol {
    static let sharedInstance = LoginService()
    
    private override init() {
    }
    
    func login(username:String, password:String, completion:@escaping (LoginResponse?, Error?) -> Void) throws {
        if username.isEmpty {
            throw ServiceError.validationError
        }
        let loginRequest = LoginRequest(username: username, password: password)
        BaseService.execute(url: "http://www.mocky.io/v2/5847ae7f3f00004928fe69de",
                input: loginRequest,
                success: {response in
                    if let response = response as? LoginResponse {
                        completion(response,nil)
                    }
                },
                error: {
                    error in
                        completion(nil,error)
                }
        )
    }
}

protocol LoginServiceProtocol {
    func login(username:String, password:String, completion:@escaping (LoginResponse?, Error?) -> Void) throws
}

class LoginRequest:ServiceRequest {
    var username:String!
    var password:String!
    
    public init(username:String, password:String) {
        self.username = username
        self.password = password
    }
    
    func toParameter () -> [String:Any] {
        var parameter = [String:String]()
        parameter["username"] = username
        parameter["password"] = password
        return parameter
    }
}

class LoginResponse: ServiceResponse {
    var userId: String?
    var lastLogin: Date?
    var age:Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        userId <- map["userId"]
        lastLogin <- (map["lastLogin"], DateFormatTransform(dateFormat: "yyyy-MM-dd"))
        age <- map["age"]
    }
}
