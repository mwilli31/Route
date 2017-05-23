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
    var accessRequests : [String : Request]
    
    let routeACListNotification = Notification.Name(rawValue:Constants.NotificationKeys.routeACListNotification)
    let nc = NotificationCenter.default
    
    private init() {
        // TODO: Retrieve from Firebase
        accessRequests = [String : Request]()
        WifiService.sharedInstance.getNetworkAccessRequests { (result) in
            Request.createRequestObjectsFromCache(requests: result as! [String : AnyObject])
            print("Printing access requests")
//            print(result)
            print(self.accessRequests)
            self.postRouteACListNotification()
        }
    }
    
    func addAccessRequest(fromRequesterUUID: String, forNetworkSSID: String, timestamp: String, requesterName: String, requesterPhoneNumber: String) {
        Request.upsertAccessRequest(fromRequesterUUID: fromRequesterUUID,
                                    forNetworkSSID: forNetworkSSID,
                                    timestamp: timestamp,
                                    requesterName: requesterName,
                                    requesterPhoneNumber: requesterPhoneNumber)
        
        print(RouteAC.sharedInstance.accessRequests)
        postRouteACListNotification()
    }

    func declineAccessRequest(fromRequesterUUID : String) {
        RouteAC.sharedInstance.accessRequests.removeValue(forKey: fromRequesterUUID)
        WifiService.sharedInstance.declineAccessRequest(fromRequesterUUID: fromRequesterUUID)
        postRouteACListNotification()
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

extension Request {
    static func createRequestObjectsFromCache(requests: [String: AnyObject]) {
        for (userUUID, value) in requests {
            guard let networks = value["networks"] as? [String: String]
                else {
                    print("no networks found")
                    continue
            }
            guard let requesterInfo = value["requesterInfo"] as? [String: String]
                else {
                    print("no requester info found")
                    continue
            }
            RouteAC.sharedInstance.accessRequests[userUUID] = Request(fromRequesterUUID: userUUID,
                                                                      networks: networks,
                                                                      requesterInfo: requesterInfo)
        }
    }
    
    static func upsertAccessRequest(fromRequesterUUID: String, forNetworkSSID: String, timestamp: String, requesterName: String, requesterPhoneNumber: String) {
        guard let _ = RouteAC.sharedInstance.accessRequests[fromRequesterUUID]
            else {
                RouteAC.sharedInstance.accessRequests[fromRequesterUUID] = Request(fromRequesterUUID: fromRequesterUUID,
                                                                                   networks: [forNetworkSSID: timestamp],
                                                                                   requesterInfo: ["name": requesterName,
                                                                                                   "phoneNumber": requesterPhoneNumber])
                return
        }

        RouteAC.sharedInstance.accessRequests[fromRequesterUUID]?.networks[forNetworkSSID] = timestamp
        RouteAC.sharedInstance.accessRequests[fromRequesterUUID]?.requesterInfo["name"] = requesterName
        RouteAC.sharedInstance.accessRequests[fromRequesterUUID]?.requesterInfo["phoneNumber"] = requesterPhoneNumber
    }
}
