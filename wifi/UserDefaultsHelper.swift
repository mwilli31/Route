//
//  UserDefaultsHelper.swift
//  wifi
//
//  Created by Michael Williams on 4/15/17.
//  Copyright © 2017 Route. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit

//protocol Utilities {
//}
//
//extension NSObject: Utilities {
//
//    
//}

class UserDefaultsHelper {
    
    static let sharedInstance = UserDefaultsHelper()
    
    enum ReachabilityStatus {
        case notReachable
        case reachableViaWWAN
        case reachableViaWiFi
    }
    
    var currentReachabilityStatus: ReachabilityStatus {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return .notReachable
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .notReachable
        }
        
        if flags.contains(.reachable) == false {
            // The target host is not reachable.
            return .notReachable
        }
        else if flags.contains(.isWWAN) == true {
            // WWAN connections are OK if the calling application is using the CFNetwork APIs.
            return .reachableViaWWAN
        }
        else if flags.contains(.connectionRequired) == false {
            // If the target host is reachable and no connection is required then we'll assume that you're on Wi-Fi...
            return .reachableViaWiFi
        }
        else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
            // The connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs and no [user] intervention is needed
            return .reachableViaWiFi
        }
        else {
            return .notReachable
        }
    }
    
    func save(state: String, ssid: String, networkUUID: String, timestamp: String) {
        let lastState = [
            "state": state,
            "ssid": ssid,
            "networkUUID": networkUUID,
            "timestamp": timestamp
        ]
    
        UserDefaults.standard.set(lastState, forKey: "lastState")
        UserDefaults.standard.synchronize()
    }
    
    func getLastSavedState() -> Dictionary<String, String>? {
        return UserDefaults.standard.dictionary(forKey: "lastState") as? Dictionary<String, String>
    }
    
    func getEstimatedCurrentState(timestamp: String) -> Dictionary<String, String>? {
        let lastSavedState : Dictionary? = getLastSavedState() as Dictionary?
        
        print(currentReachabilityStatus) //true connected
        
        //verify connected to wifi
        if currentReachabilityStatus == .reachableViaWiFi && lastSavedState != nil {
            //check to see if timestamp is within 300 seconds
            let newTimestamp : Int = Int(timestamp)!
            let oldTimestamp : Int = Int(lastSavedState!["timestamp"]!)!
            
            let diff = newTimestamp - oldTimestamp
            if diff <= 300 {
                return lastSavedState
            }
        } else {
            //not connected to wifi, so unsure of state
            return nil
        }
        
        return nil
        
    }
    
}




