//
//  OrganizationInfoViewController.swift
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/30/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

import UIKit
import Alamofire

@objc class OrganizationInfoViewController: UIViewController {

    var org: Organization?
    var salarySum: Int32?
    var requestManager = RequestManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Utility
    
    func fibonacci(_ number: Int) -> (Int64) {
        if (number == 1 || number == 2) {
            return 1
        }
        if number == 0 {
            return 0
        }
        return fibonacci(number - 1) + fibonacci(number - 2)
    }
    
    //MARK: - Alert
    
    func orgsAlert(_ orgsName: [String]) {
        let alertController = UIAlertController(title: "Please select", message: "Choose one of organization", preferredStyle: .actionSheet)
        
        for orgName in orgsName {
            let alert = UIAlertAction(title: orgName, style: .default) { (_) in
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notification.Name.kOrganizationHasPicked), object: self, userInfo: ["name":orgName])
                self.navigationController?.popViewController(animated: true)
            }
            alertController.addAction(alert)
        }
        self.present(alertController, animated: true)
    }
    
    func salaryAlert(title: String, message: String, style: UIAlertControllerStyle) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Handlers
    
    @IBAction func calcSalarySumAction(_ sender: Any) {
        self.salarySum = self.org?.calculateSalarySum()
        self.salaryAlert(title: "Salary Sum", message: "\(salarySum ?? 0)", style: .alert);
    }
    
    @IBAction func randomizeOrderAction(_ sender: Any) {
        self.org?.randomizeOrder()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notification.Name.kEmployeesOrderHasChanged), object: self)
    }
    
    @IBAction func fetchOrganizationsAction(_ sender: Any) {
        requestManager.fetchOrganizations { (dict) in
            
            guard let dictionary = dict else { return }
            var orgsName = [String]()
            
            for obj in dictionary {
                orgsName.append(obj["name"] as! String)
            }
            
            self.orgsAlert(orgsName)
        }
    }
    
    @IBAction func fibonacciAction(_ sender: Any) {
        SVProgressHUD.show()
        
        DispatchQueue.global(qos: .background).async(execute: {
            let res = self.fibonacci(40)
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                if let navController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController,
                    let visibleVC = navController.visibleViewController {
                    visibleVC.fibonacciAlert(res)
                }
                else {
                    self.fibonacciAlert(res)
                }
            }
        })
    }
}

//MARK: - UIViewController extension

extension UIViewController {
    func fibonacciAlert(_ number: Int64) {
        DispatchQueue.global(qos: .background).async {
            let alertController = UIAlertController(title: "Fibonacci", message: "40th number is \(number)", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
            alertController.addAction(action)
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

extension NSNotification.Name {
    static let kEmployeesOrderHasChanged = "EmployeesOrderHasChanged"
    static let kOrganizationHasPicked = "OrganizationHasPicked"
}
