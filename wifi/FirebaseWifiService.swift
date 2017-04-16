//
//  FirebaseWifiService.swift
//  wifi
//
//  Created by Michael Williams on 4/8/17.
//  Copyright © 2017 Route. All rights reserved.
//

import Foundation
import Firebase
import KeychainSwift

class FirebaseWifiService {
    
    static let sharedInstance = FirebaseWifiService()
    
    
    // TODO: Will make sense to move this code to eventually seperate private functions to handle the posting of data
    // to multiple indexes in our system (don't worry now, since we are moving away from Firebase eventually)
    func postCurrentWifiConnectionDetails(ssid: String, networkUUID: String, timestamp: String, command: String) {
        
        let wifiConnectionDataForTimestamp = [
            "ssid" : ssid,
            "networkUUID" : networkUUID,
            "command" : command
        ]
        
        let wifiConnectionDataForNetworkUUID = [
            "ssid" : ssid,
            "timestamp" : timestamp,
            "command" : command
        ]
        
        let wifiConnectionDataForNetworkSSID = [
            "networkUUID" : networkUUID,
            "timestamp" : timestamp,
            "command" : command
        ]
        
        let userUUID = UserService.sharedInstance.getCurrentUserUUID()
        
        //make sure that a user is currently logged in
        if userUUID != "" {
            var databaseRef: FIRDatabaseReference!
            databaseRef = FIRDatabase.database().reference().child("/users/" + userUUID)
            
            let baseUserTimestampPath: String = "/connectionHistoryByTimestamp/" + timestamp
            
            let baseUserNetworkPath = "/connectionHistoryByNetworkUUID/" + networkUUID
            let key1 = databaseRef.child(baseUserNetworkPath).childByAutoId().key
            let userNetworkPath : String = baseUserNetworkPath + "/\(key1)"
            
            let baseUserSSIDPath = "/connectionHistoryByNetworkSSID/" + ssid
            let key2 = databaseRef.child(baseUserSSIDPath).childByAutoId().key
            let userSSIDPath : String = baseUserSSIDPath + "/\(key2)"
            
            let updates = [ baseUserTimestampPath : wifiConnectionDataForTimestamp,
                            userNetworkPath : wifiConnectionDataForNetworkUUID,
                            userSSIDPath : wifiConnectionDataForNetworkSSID ]
            
            databaseRef.updateChildValues(updates)
            
        }
    }
    
    

}