//
//  LoginController.swift
//  LoginCustomer
//
//  Created by Hanataba on 29/2/2563 BE.
//  Copyright © 2563 Hanataba. All rights reserved.
//

import UIKit

class LoginController : UIViewController {
    
    @IBOutlet weak var usernameTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var loginButton : UIButton!
    let defaults = UserDefaults.standard
    let segueIden = "UserTable"
    
    var customers : [Customer]?
    
    var loginApi = LoginAPI()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        if let _ = defaults.string(forKey: "token"){
            self.performSegue(withIdentifier: self.segueIden, sender: self)
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        let user = usernameTextField.text ?? ""
        let pass = passwordTextField.text ?? ""
        
        loginApi.execute( completion: { result in
            if(try! result.get().status != 200){
                return
            }
            self.customers = try! result.get().customers
            
            let cus = try! result.get().customers
            let token = try! result.get().token
            
            self.defaults.set(token, forKey: "token")
        
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(cus){
               UserDefaults.standard.set(encoded, forKey: "SavedCustomers")
            }
            
            self.performSegue(withIdentifier: self.segueIden, sender: self)
        }, user: user, pass: pass)
        
    }
    
    
    
}
