//
//  WifiService.swift
//  wifi
//
//  Created by Michael Williams on 4/10/17.
//  Copyright © 2017 Route. All rights reserved.
//

import Foundation
import NetworkExtension


class WifiService {
    
    static let sharedInstance = WifiService()

    
    // MARK: Simple Data Collection API's

    func postCurrentWifiConnectionDetails(ssid: String, networkUUID: String, timestamp: String, command: String) {
        print("POSTING")
        FirebaseWifiService.sharedInstance.postCurrentWifiConnectionDetails(ssid: ssid, networkUUID: networkUUID, timestamp: timestamp, command: command)
    }
    
    // MARK: Simple Data Posting API's
    
    func postUserAddedRoute (ssid: String, password: String, name: String, address: String) {
        FirebaseWifiService.sharedInstance.postUserAddedRoute(ssid: ssid, password: password, name: name, address: address)
    }
    
    // MARK: Available Networks API's
    
    func observeAllPublicWifiNetworks() {
        FirebaseWifiService.sharedInstance.observeAllPublicWifiNetworks()
    }
    
    func observeAllAccessiblePrivateWifiNetworks() {
        FirebaseWifiService.sharedInstance.observeAllAccessiblePrivateWifiNetworks()
    }
    
    func getAccessibleSpots() -> Dictionary<String, Any>? {
        return UserDefaults.standard.dictionary(forKey: "accessibleSpots")
    }
    
//    func getMatchingNetworks(forNetworkList: [NEHotspotNetwork]) -> [Dictionary<String, Any>] {
//        //get spots
//        let spots: Dictionary? = getAccessibleSpots()
//        var matchedNetworks : [NEHotspotNetwork?] = []
//        
//        //match against network list
//        if(spots != nil) {
//            for net in forNetworkList {
//                let netUUID = net.ssid + "_" + LocationManager.sharedInstance.
//                print(net.ssid)
//                print(spots?[net.ssid] ?? "no matching spot")
//                if(spots![net.ssid] != nil) {
//                    let networkDict = [
//                        "NEHotspotNetwork": net,
//                        "password": spots![net.ssid]
//                    ]
//                    matchedNetworks.append(net)
//                }
//            }
//        }
//        print("matched")
//        print(matchedNetworks)
//        return matchedNetworks
//    }
    
    func updateNetworkListCache(forNetworkList: Array<Any>) {
        
    }
    
    func getNetworkAccessRequests(completion:@escaping (_ result: NSDictionary) -> Void)  {
        FirebaseWifiService.sharedInstance.getNetworkAccessRequests { (result) in
            completion(result)
        }
    }
    
    func postNetworkAccessRequest(fromRequesterUUID: String, forNetworkSSID: String, timestamp: String, requesterName: String, requesterPhoneNumber: String) {
        FirebaseWifiService.sharedInstance.postNetworkAccessRequest(fromRequesterUUID: fromRequesterUUID,
                                                                    forNetworkSSID: forNetworkSSID,
                                                                    timestamp: timestamp,
                                                                    requesterName: requesterName,
                                                                    requesterPhoneNumber: requesterPhoneNumber)
        
        RouteAC.sharedInstance.addAccessRequest(fromRequesterUUID: fromRequesterUUID,
                                                forNetworkSSID: forNetworkSSID,
                                                timestamp: timestamp,
                                                requesterName: requesterName,
                                                requesterPhoneNumber: requesterPhoneNumber)
        
    }
    
    func purgeUserDataInclusive(fromRef: String) {
        FirebaseWifiService.sharedInstance.purgeUserDataInclusive(fromRef: fromRef)
    }
}
