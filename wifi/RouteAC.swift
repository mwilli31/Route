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
    var accessRequests : [String : AnyObject]
    
    let routeACListNotification = Notification.Name(rawValue:Constants.NotificationKeys.routeACListNotification)
    let nc = NotificationCenter.default
    
    private init() {
        // TODO: Retrieve from Firebase
        accessRequests = [String : AnyObject]()
        WifiService.sharedInstance.getNetworkAccessRequests { (result) in
            // Deep copy needed?
            self.accessRequests = (result as? [String : AnyObject])!
            print(self.accessRequests)
            self.postRouteACListNotification()
        }
    }
    
    func addAccessRequest(fromRequesterUUID: String, value: NSDictionary) {
        RouteAC.sharedInstance.accessRequests[fromRequesterUUID] = value
        print(RouteAC.sharedInstance.accessRequests)
        postRouteACListNotification()
    }
    
    func getAccessRequestFrom(user: String) -> String {
        return user
    }

    func denyAccessRequest(user : String) {
    }

    func approveAccessRequest(user : String) {
        // TODO: Firebase activity
    }
    
    func pendingAccessRequestUsersArray() -> Array<String> {
        return Array(RouteAC.sharedInstance.accessRequests.keys)
    }
    
    private func postRouteACListNotification() {
        print("Notifying Requests View Controller that Route AC List has been updated.")
        self.nc.post(name:self.routeACListNotification,
                     object: nil,
                     userInfo:nil
        )
    }
}
