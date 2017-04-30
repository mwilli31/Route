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
    var accessRequests : [String:String]
    
    private init() {
        // TODO: Retrieve from Firebase
        accessRequests = [String:String]()
    }

    func denyAccessRequest(user : String) {
        RouteAC.sharedInstance.accessRequests.removeValue(forKey: user)
    }

    func approveAccessRequest(user : String) {
        RouteAC.sharedInstance.accessRequests.removeValue(forKey: user)
        // TODO: Firebase activity
    }
    
    func pendingAccessRequestUsersArray() -> Array<String> {
        return Array(accessRequests.keys)
    }
    
    func updateAccessRequests(updatedRequests : NSDictionary) {
        RouteAC.sharedInstance.accessRequests = updatedRequests.mutableCopy() as! [String : String]
        // TODO: Notify Requests VC that data has been updated
    }
}
