//
//  RouteAC.swift
//  wifi
//
//  Created by Sajay Shah on 4/18/17.
//  Copyright © 2017 Route. All rights reserved.
//

import Foundation

class RouteAC {
    
    static let sharedInstance = RouteAC()
    var accessRequestsByAutoID : [String : [String:String]]
    var accessRequestsByUserID : [String:String]
    
    let connectionStateNotification = Notification.Name(rawValue:Constants.NotificationKeys.connectionStateNotification)
    let nc = NotificationCenter.default
    
    private init() {
        // TODO: Retrieve from Firebase
        accessRequestsByAutoID = [String : [String:String]]()
        accessRequestsByUserID = [String:String]()
        WifiService.sharedInstance.getNetworkAccessRequests { (result) in
            // Deep copy needed?
            self.accessRequestsByAutoID = result as! [String : [String:String]]
            self.parseAccessRequestsByAutoID()
        }
    }
    
    func parseAccessRequestsByAutoID() {
        let temp = RouteAC.sharedInstance.accessRequestsByAutoID.values
        
        for item in temp {
            RouteAC.sharedInstance.accessRequestsByUserID[item["from"]!] = "dat boi"
        }
        // Done parsing notify Requests VC
        postNetworkConnectionStateNotification()
    }
    
    func addAccessRequest(user: String) {
        RouteAC.sharedInstance.accessRequestsByUserID[user] = "someRoute"
    }
    
    func getAccessRequestFrom(user: String) -> String {
        return RouteAC.sharedInstance.accessRequestsByUserID[user]!
    }

    func denyAccessRequest(user : String) {
        RouteAC.sharedInstance.accessRequestsByUserID.removeValue(forKey: user)
    }

    func approveAccessRequest(user : String) {
        RouteAC.sharedInstance.accessRequestsByUserID.removeValue(forKey: user)
        // TODO: Firebase activity
    }
    
    func pendingAccessRequestUsersArray() -> Array<String> {
        return Array(RouteAC.sharedInstance.accessRequestsByUserID.keys)
    }
    
    private func postNetworkConnectionStateNotification() {
        print("sending local noti")
        self.nc.post(name:self.connectionStateNotification,
                     object: nil,
                     userInfo:[
                        "update":true
            ])
        
    }
}
