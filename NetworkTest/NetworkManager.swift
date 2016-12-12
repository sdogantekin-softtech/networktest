//
//  NetworkManager.swift
//  NetworkTest
//
//  Created by Serkan Doğantekin
//  Copyright © 2016 Serkan Doğantekin. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class NetworkManager {
    static let sharedInstance = NetworkManager()
    
    private var sessionManager:SessionManager!
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func executeJsonService<T:Mappable>(url:String,
                            httpMethod:HTTPMethod = .post,
                            request:[String:Any]?,
                            responseType:T.Type,
                            successCallback:@escaping (_ data:ServiceResponse) -> Void,
                            errorCallback:@escaping (_ error:Error) -> Void) {
        /* 
         ClientId TimeStamp UserId DeviceId Token Hash
         */
        let headers: HTTPHeaders = ["Content-Type": "application/json; charset=utf-8"]
        
        sessionManager.request(url,
                               method: httpMethod,
                               parameters: request,
                               encoding: JSONEncoding.default,
                               headers: headers)
            .validate()
            .responseObject { (response:DataResponse<T>) in
                switch(response.result) {
                case .success(_):
                    if let result = response.result.value {
                        successCallback(result as! ServiceResponse)
                    }
                    break
                case .failure(let error):
                    errorCallback(error)
                    break
                    
            }
        }
    }
}
