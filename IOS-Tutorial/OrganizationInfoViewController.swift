//
//  OrganizationInfoViewController.swift
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/30/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

import UIKit

@objc class OrganizationInfoViewController: UIViewController {

    var org: Organization?
    var salarySum: Int32?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Alert
    
    func alert(title: String, message: String, style: UIAlertControllerStyle) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Handlers
    
    @IBAction func calcSalarySumAction(_ sender: Any) {
        self.salarySum = self.org?.calculateSalarySum()
        self.alert(title: "Salary Sum", message: "\(salarySum ?? 0)", style: .alert);
    }
    
    @IBAction func randomizeOrderAction(_ sender: Any) {
        self.org?.randomizeOrder()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notification.Name.kEmployeesOrderHasChanged), object: self)
    }
}


extension NSNotification.Name {
    static let kEmployeesOrderHasChanged = "EmployeesOrderHasChanged";
}
