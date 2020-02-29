//
//  CustomerDetail.swift
//  LoginCustomer
//
//  Created by Hanataba on 29/2/2563 BE.
//  Copyright © 2563 Hanataba. All rights reserved.
//

import Foundation

struct CustomerDetail {
    var data : CustomerDetailData
    var status : Int
}

struct CustomerDetailData {
    var customerGrade : String
    var id : String
    var isCustomerPremium : String
    var name : String
    var sex : String
}
