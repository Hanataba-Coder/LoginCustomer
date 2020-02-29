//
//  LoginAPI.swift
//  LoginCustomer
//
//  Created by Hanataba on 29/2/2563 BE.
//  Copyright © 2563 Hanataba. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginAPI {
    func execute(completion: @escaping (Result<CustomersTokenModel, Error>) -> Void, user: String, pass: String) {
        
        let parameters = [
          "username": user,
          "password": pass
        ]
        
        let headers: HTTPHeaders = [
          "Content-Type": "application/json"
        ]
        
        AF.request("https://neversitup.pythonanywhere.com/login",
                   method: .post, parameters: parameters, encoding: JSONEncoding.default,
                   headers: headers)
            .response { (respone) in
                
            if let error = respone.error {
                DispatchQueue.main.async {
                    print(error)
                    completion(Result.failure(error))
                }
                return
            }
            
            guard let data = respone.data else {return}
            
            do{
                let json = try JSON(data: data)
                let customers : [Customer] =  json["customers"].compactMap { (String, JSON) in
                    
                    let id = (JSON["id"]).description
                    let name = (JSON["name"]).description
                    
                    let customer = Customer(id: id, name: name)
                    
                    return customer
                }
                
                let status = json["status"].int
                let token = json["token"].description
            
                let customerTokenModel = CustomersTokenModel(customers: customers, status: status!, token: token)
                
                DispatchQueue.main.async {
                  completion(Result.success(customerTokenModel))
                }
            }
            catch{
                print(error.localizedDescription)
            }
            
        }
    }
}
