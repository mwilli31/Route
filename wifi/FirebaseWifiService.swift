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
    

    
    func currentWifiConnectionDetailsPostFirebase(ssid: String, networkUUID: String, timestamp: String) {
        
        let wifiConnectionDataForTimestamp: NSDictionary! = [
            "ssid" : ssid,
            "networkUUID" : networkUUID
        ]
        
        let wifiConnectionDataForNetworkUUID: NSDictionary! = [
            "ssid" : ssid,
            "timestamp" : timestamp
        ]
        
        var databaseRef: FIRDatabaseReference!
        databaseRef = FIRDatabase.database().reference()
        
        //make sure that a user is currently logged in
        let userUUID = UserService.sharedInstance.getCurrentUserUUID()
        print("userID:" + userUUID)
        if userUUID != "" {
            print("users/" + userUUID + "/wifiConnectionHistory/" + timestamp)
            databaseRef.child("users/" + userUUID + "/wifiConnectionHistory/" + timestamp).setValue(wifiConnectionDataForTimestamp)
            databaseRef.child("users/" + userUUID + "/wifiConnectionHistory/" + networkUUID).setValue(wifiConnectionDataForNetworkUUID)
            databaseRef.child("users").child(userUUID).child("wifiConnectionHistory").setValue([timestamp: wifiConnectionDataForTimestamp])
            databaseRef.child("users").child(userUUID).setValue(["username": "mwilli32"])

        }
    }
    
}
