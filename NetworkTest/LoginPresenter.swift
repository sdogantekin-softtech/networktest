//
//  LoginPresenter.swift
//  NetworkTest
//
//  Created by Serkan Doğantekin
//  Copyright © 2016 Serkan Doğantekin. All rights reserved.
//

import Foundation

class LoginPresenter:LoginPresenterProtocol {
    var view:LoginControllerProtocol!
    var loginService:LoginServiceProtocol!
    
    init(_ view:LoginControllerProtocol) {
        self.view         = view
        self.loginService = LoginService.sharedInstance
    }
    
    func login(username: String, password: String) {
        do {
            try loginService.login(username:username, password:password, completion:  {
                response, error in
                guard let response = response else {
                    self.view.showMessage(title: "Alert", message: error!.localizedDescription)
                    return
                }
                self.view.showMessage(title: "Result", message: "userid : \(response.userId) - last : \(response.lastLogin) - age : \(response.age)")
            })
        } catch(let error) {
            self.view.showMessage(title: "Alert", message: error.localizedDescription)
        }
    }
}

protocol LoginPresenterProtocol {
    func login(username:String, password:String)
}

