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
    
    // MARK: Simple Data Collection API's

    func postCurrentWifiConnectionDetails(ssid: String, networkUUID: String, timestamp: String, command: String) {
        print("POSTING")
        FirebaseWifiService.sharedInstance.postCurrentWifiConnectionDetails(ssid: ssid, networkUUID: networkUUID, timestamp: timestamp, command: command)
    }
    
    // MARK: Simple Data Posting API's
    
    func postUserAddedRoute (ssid: String, password: String, name: String) {
        FirebaseWifiService.sharedInstance.postUserAddedRoute(ssid: ssid, password: password, name: name)
    }
    
    // MARK: Available Networks API's
    
    func getMatchingNetworks(forNetworkList: Array<Any>) -> Array<Dictionary<String, Any>> {
        
        var matchedNetworks : Array<Dictionary<String, Any>> = []
        
        let matchedNetwork : Dictionary! = [
            "ssid": "Hi",
            "password": "hi",
            "networkUUID": "hi"
        ]
        
        matchedNetworks.append(matchedNetwork)
        
        return matchedNetworks
        
    }
    
    func updateNetworkListCache(forNetworkList: Array<Any>) {
        
    }
}
