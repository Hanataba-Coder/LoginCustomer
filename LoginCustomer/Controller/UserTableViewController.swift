//
//  UserTableViewController.swift
//  LoginCustomer
//
//  Created by Hanataba on 29/2/2563 BE.
//  Copyright © 2563 Hanataba. All rights reserved.
//

import UIKit

class UserTableViewController : UITableViewController {
    var customers : [Customer]?
    let defaults = UserDefaults.standard
    var token = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userToken = defaults.string(forKey: "token"){
            token = userToken
        }
        
        if let savedPerson = defaults.object(forKey: "SavedCustomers") as? Data {
            let decoder = JSONDecoder()
            if let loadedCustomer = try? decoder.decode(Array.self, from: savedPerson) as [Customer] {
                customers = loadedCustomer
            }
        }
        
    }
    @IBAction func logoutPressed(_ sender: UIButton) {
        defaults.set(nil, forKey: "token")
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - DataSource
extension UserTableViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customers?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        if let customer = customers?[indexPath.row]{
            cell.customerName.text = customer.name
        } else {
            return cell
        }
        return cell
    }
}

//MARK: - Delegate
extension UserTableViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cell", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! CustomerDetailViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            if let customer = customers?[indexPath.row] {
                destinationVC.id = customer.id
                destinationVC.token = token
            }
            
        }
    }
}
