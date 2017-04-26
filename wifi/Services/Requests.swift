//
//  Requests.swift
//  wifi
//
//  Created by Michael Williams on 4/23/17.
//  Copyright © 2017 Route. All rights reserved.
//

import Foundation
import Firebase


class Requests {
    
    static let sharedInstance = Requests()
    
    /*******************************************************************************************
     Ask for access APIs
     ********************************************************************************************/
    
    func askForAccess(toNetworkUUID: String, ownerUUID: String) {
        let userUUID = UserService.sharedInstance.getCurrentUserUUID()

        let value = [
            "networkUUID" : toNetworkUUID,
            "userUUID" : userUUID,
            "ownerUUID" : ownerUUID
        ]
        
        //make sure that a user is currently logged in
        if userUUID != "" {
            var databaseRef: FIRDatabaseReference!
            databaseRef = FIRDatabase.database().reference().child("/accessRequests")
            
            let key = databaseRef.childByAutoId().key
            let accessRequestsPath : String = "/\(key)"
            
            let updates = [ accessRequestsPath : value]
            
            databaseRef.updateChildValues(updates)
            
        }

    }
    
    /*******************************************************************************************
     Grant access APIs
     ********************************************************************************************/
    
    func grantAccess(ssid: String, networkUUID: String, timestamp: String, command: String) {
        print("POSTING")
        FirebaseWifiService.sharedInstance.postCurrentWifiConnectionDetails(ssid: ssid, networkUUID: networkUUID, timestamp: timestamp, command: command)
    }
    
}
