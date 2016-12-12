//
//  BaseService.swift
//  NetworkTest
//
//  Created by Serkan Doğantekin
//  Copyright © 2016 Serkan Doğantekin. All rights reserved.
//

import ObjectMapper

class BaseService {
    class func execute(url:String, input:ServiceRequest, success:@escaping (ServiceResponse) -> Void, error:@escaping (Error) -> Void) {
        NetworkManager.sharedInstance.executeJsonService(url: "http://www.mocky.io/v2/5847ae7f3f00004928fe69de", request:input.toParameter(), responseType:LoginResponse.self, successCallback: success, errorCallback: error)
    }
}

protocol ServiceRequest {
    func toParameter () -> [String:Any]
}

protocol ServiceResponse : Mappable {
}

public class DateFormatTransform: TransformType {
    var dateFormat = DateFormatter()

    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = DateFormatter()
        self.dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }

    public typealias Object = Date
    public typealias JSON   = String

    public func transformFromJSON(_ value: Any?) -> Date? {
        if let dateString = value as? String {
            return self.dateFormat.date(from:dateString)
        }
        return nil
    }

    public func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return self.dateFormat.string(from:date)
        }
        return nil
    }
}

enum ServiceError:Error {
    case validationError
    case notSupportedOperationError
}
