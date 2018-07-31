//
//  RequestManager.swift
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/30/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

import UIKit
import Alamofire

class RequestManager: NSObject {

    func fetchOrganizations(completion: @escaping ([[String:Any]]?) -> ()) {
        guard let url = URL(string: "http://gitlab.faifly.com/ios-general/ios-tutorial/uploads/ffffec34fa4a727922bb1e09cc24b21d/tutorial.json") else {
            completion(nil)
            return
        }
        Alamofire.request(url).responseJSON { response in
            guard response.result.error == nil else {
                print("Error while fetching: \(String(describing: response.result.error))")
                completion(nil)
                return
            }
            
            guard
                let orgsObj = response.result.value as? [String: Any],
                let orgObj = orgsObj["organizations"] as? [[String: Any]]
            else {
                print("Malformed data received from fetchOrganizations service")
                completion(nil)
                return
            }
            
            OrganizationMO.deleteAllOrganizations()
            
            for obj in orgObj {
                guard let employees = obj["employees"] as? [[String:Any]] else { print("Malformed data"); completion(nil); return }
                var empArr: [EmployeeMO] = []
                
                for emp in employees {
                    if (emp["isActive"] as! Bool) {
                        empArr.append(EmployeeMO.addNewEmployee(withFirstName: emp["first_name"] as! String,
                                                                lastName: emp["last_name"] as! String,
                                                                salary: ((emp["salary"] as? Int32) ?? 0),
                                                                dateOfBirth: self.generateRandomDate(daysBack: 40*365) ?? Date.init(timeIntervalSinceNow: 0)))
                    }
                }
                OrganizationMO.addNewOrganization(withName: obj["name"] as! String, andEmployees: empArr)
            }
            
            completion(orgObj)
        }
    }
    
    func generateRandomDate(daysBack: Int)-> Date?{
        let day = arc4random_uniform(UInt32(daysBack))+1

        
        let today = Date(timeIntervalSinceReferenceDate: 0)
        let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.day = -Int(day - 1)
        
        let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) )
        return randomDate
    }
}
