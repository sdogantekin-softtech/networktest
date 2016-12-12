//
//  LoginController.swift
//  NetworkTest
//
//  Created by Serkan Doğantekin
//  Copyright © 2016 Serkan Doğantekin. All rights reserved.
//

import UIKit

class LoginController: UIViewController, LoginControllerProtocol {
    var presenter:LoginPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        presenter = LoginPresenter(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        presenter.login(username: "serkan", password: "1234")
    }
    
    func showMessage(title:String, message:String) {
        let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

protocol LoginControllerProtocol {
    func showMessage(title:String, message:String)
}
