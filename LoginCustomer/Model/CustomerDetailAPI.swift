//
//  CustomerDetailAPI.swift
//  LoginCustomer
//
//  Created by Hanataba on 29/2/2563 BE.
//  Copyright © 2563 Hanataba. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CustomerDetailAPI {
    func execute(completion: @escaping (Result<CustomerDetail, Error>) -> Void, token: String, customerId: String) {
        
        let parameters = [
          "token": token,
          "customerId": customerId
        ]
        
        let headers: HTTPHeaders = [
          "Content-Type": "application/json"
        ]
        
        AF.request("https://neversitup.pythonanywhere.com/getCustomerDetail",
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
//                print(json)
                
                let status = json["status"].int
                
                let id = json["data"]["id"].description
                let name = json["data"]["name"].description
                let customerGrade = json["data"]["customerGrade"].description
                let isCustomerPremium = json["data"]["isCustomerPremium"].description
                let sex = json["data"]["sex"].description
                
                let customerDetailData = CustomerDetailData(customerGrade: customerGrade, id: id, isCustomerPremium: isCustomerPremium, name: name, sex: sex)
                
                let customerDetail = CustomerDetail(data: customerDetailData, status: status!)
                
                DispatchQueue.main.async {
                  completion(Result.success(customerDetail))
                }
            }
            catch{
                print(error.localizedDescription)
            }
            
        }
    }
}
