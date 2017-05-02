//
//  ConnectionStateHelper.swift
//  wifi
//
//  Created by Michael Williams on 4/15/17.
//  Copyright © 2017 Route. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit
import UserNotifications

class ConnectionStateHelper {
    
    static let sharedInstance = ConnectionStateHelper()
    
    let connectionStateNotification = Notification.Name(rawValue:Constants.NotificationKeys.connectionStateNotification)
    let nc = NotificationCenter.default
    
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
    
    func saveConnectedNetwork(withSSID: String, networkUUID: String, timestamp: String) {
        let lastConnectedNetwork = [
            "ssid": withSSID,
            "networkUUID": networkUUID,
            "timestamp": timestamp
        ]
        
        UserDefaults.standard.set(lastConnectedNetwork, forKey: "lastConnectedNetwork")
        UserDefaults.standard.synchronize()
    }
    
    func save(state: String) {
        UserDefaults.standard.set(state, forKey: "lastState")
    }
    
    func getLastSavedState() -> Constants.ConnectionState {
        return (UserDefaults.standard.object(forKey: "lastState") as? Constants.ConnectionState)!
    }

    func getLastConnectedNetwork() -> Dictionary<String, String>? {
        return UserDefaults.standard.dictionary(forKey: "lastConnectedNetwork") as? Dictionary<String, String>
    }
    
    func getEstimatedCurrentState() -> Dictionary<String, Any>? {
        let lastConnectedNetwork : Dictionary? = getLastConnectedNetwork() as Dictionary?
        var dict : Dictionary<String, Any> = [:]
        
        print(currentReachabilityStatus) //true connected
        
        //verify connected to wifi
        if currentReachabilityStatus == .reachableViaWiFi && lastConnectedNetwork != nil {
            //check to see if timestamp is within 300 seconds
            let newTimestamp : Int = Int(Date().timeIntervalSince1970.rounded())
            let oldTimestamp : Int = Int(lastConnectedNetwork!["timestamp"]!)!
            
            let diff = newTimestamp - oldTimestamp
            if diff <= 300 {
                dict["state"] = Constants.ConnectionState.ConnectedToSSID
                dict["ssid"] = lastConnectedNetwork?["ssid"]
            }
        } else if currentReachabilityStatus == .reachableViaWiFi  {
            //connected to wifi, but unsure the network
            dict["state"] = Constants.ConnectionState.Connected
        } else if currentReachabilityStatus == .reachableViaWWAN {
            //on cellular, thus let's look for available networks
            dict["state"] = Constants.ConnectionState.Discovering
        } else if currentReachabilityStatus == .notReachable {
            // not reachable, so either wifi is turned off or you are in a location without cellular service
            dict["state"] = Constants.ConnectionState.NeedSettings
        } else {
            //really unsure
            dict["state"] = Constants.ConnectionState.NeedSettings
        }
        
        return dict
    }
    
    func updateCurrentState() {
        let lastConnectedNetwork : Dictionary? = getLastConnectedNetwork() as Dictionary?

        print(currentReachabilityStatus) //true connected
        
        //verify connected to wifi
        if currentReachabilityStatus == .reachableViaWiFi && lastConnectedNetwork != nil {
            if lastConnectedNetwork!["ssid"] != nil {
                //check to see if timestamp is within 300 seconds
                let newTimestamp : Int = Int(Date().timeIntervalSince1970.rounded())
                let oldTimestamp : Int = Int(lastConnectedNetwork!["timestamp"]!)!
                let diff = newTimestamp - oldTimestamp
                if diff <= 300 {
                    let msg : String = Constants.ConnectionStateMessages.connectedMessage + " To " + lastConnectedNetwork!["ssid"]!
                    publishConnectionState(forState: Constants.ConnectionState.ConnectedToSSID, withMessage:msg)
                } else {
                    publishConnectionState(forState: Constants.ConnectionState.Connected, withMessage: Constants.ConnectionStateMessages.connectedMessage)
                }
            } else {
                publishConnectionState(forState: Constants.ConnectionState.Connected, withMessage: Constants.ConnectionStateMessages.connectedMessage)
            }
            
        } else if currentReachabilityStatus == .reachableViaWiFi  {
            //connected to wifi, but unsure the network
            publishConnectionState(forState: Constants.ConnectionState.Connected, withMessage: Constants.ConnectionStateMessages.connectedMessage)
        } else if currentReachabilityStatus == .reachableViaWWAN {
            //on cellular, thus let's look for available networks
            publishConnectionState(forState: Constants.ConnectionState.Discovering, withMessage: Constants.ConnectionStateMessages.discoverMessage)
        } else if currentReachabilityStatus == .notReachable {
            // not reachable, so either wifi is turned off or you are in a location without cellular service
            publishConnectionState(forState: Constants.ConnectionState.NeedSettings, withMessage: Constants.ConnectionStateMessages.needSettingsNoServiceMessage)
        } else {
            //really unsure
            publishConnectionState(forState: Constants.ConnectionState.NeedSettings, withMessage: Constants.ConnectionStateMessages.needSettingsNoServiceMessage)
        }
        
    }
    
    private func publishConnectionState(forState: Constants.ConnectionState, withMessage: String) {
        
        self.nc.post(name:connectionStateNotification,
                     object: nil,
                     userInfo:[
                        Constants.NotificationKeys.connectionStateNotificationKey:forState,
                        Constants.NotificationKeys.connectionStateMessageNotificationKey:withMessage
            ])
    }
    
    
    
}




