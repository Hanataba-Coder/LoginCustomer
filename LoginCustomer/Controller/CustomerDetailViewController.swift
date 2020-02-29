//
//  CustomerDetailViewController.swift
//  LoginCustomer
//
//  Created by Hanataba on 29/2/2563 BE.
//  Copyright © 2563 Hanataba. All rights reserved.
//

import UIKit

class CustomerDetailViewController: UIViewController {
    
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var customerSex: UILabel!
    @IBOutlet weak var customerGrade: UILabel!
    @IBOutlet weak var customerPremium: UILabel!
    
    var token : String?
    var id : String?
    let customerDetailAPI = CustomerDetailAPI()
    
    var customerDetail : CustomerDetail?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let id = id, let token = token {
            print("id: \(id), token: \(token)")
            
            customerDetailAPI.execute(completion: { result in
                let data = try? result.get()
                if let dataNew = data {
                    print(dataNew)
                    if dataNew.status == 200 {
                        self.customerName.text = dataNew.data.name
                        self.customerSex.text = dataNew.data.sex
                        self.customerGrade.text = dataNew.data.customerGrade
                        self.customerPremium.text = dataNew.data.isCustomerPremium
                    }else{
                        return
                    }
                }
                
            }, token: token, customerId: id)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
