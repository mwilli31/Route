//
//  WifiService.swift
//  wifi
//
//  Created by Michael Williams on 4/10/17.
//  Copyright © 2017 Route. All rights reserved.
//

import Foundation

class WifiService {
    
    static let sharedInstance = WifiService()
    
    /*******************************************************************************************
                                    Simple Data Collection API's
     ********************************************************************************************/

    func currentWifiConnectionDetailsPost(ssid: String, networkUUID: String, timestamp: String) {
        print("POSTING")
        FirebaseWifiService.sharedInstance.currentWifiConnectionDetailsPostFirebase(ssid: ssid, networkUUID: networkUUID, timestamp: timestamp)
    }
    
    
}
