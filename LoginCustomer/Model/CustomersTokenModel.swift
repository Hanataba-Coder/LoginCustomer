//
//  CustomersTokenModel.swift
//  LoginCustomer
//
//  Created by Hanataba on 29/2/2563 BE.
//  Copyright © 2563 Hanataba. All rights reserved.
//

import Foundation

struct CustomersTokenModel : Codable{
    var customers : [Customer]
    var status : Int
    var token : String
}


