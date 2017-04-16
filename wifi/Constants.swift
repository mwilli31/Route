//
//  ConstantsAndKeys.swift
//  wifi
//
//  Created by Sajay Shah on 3/7/17.
//  Copyright © 2017 Route. All rights reserved.
//

struct Constants {
    
    struct NotificationKeys {
        static let connectionStateNotification = "ConnectionStateNotification"
        static let connectionStateNotificationKey = "connectionState"
    }
    
    struct TimersAndDelays {
        static let discoveringRoutesTimer : Double! = 3.0
    }
    
    struct ConnectionStateMessages {
        static let discoverMessage = "Discovering Routes"
        static let foundRoutesMessage = "Discovered nearby routes"
        static let authenticateMessage = "Authenticating Route"
        static let connectedMessage = "Connected"
    }
    
    struct Segues {
    }
    
    struct KeychainKeys {
        static let routeFirebaseEmail = "routeFirebaseEmail"
        static let routeFirebasePassword = "routeFirebaseUserPassword"
    }
    
    struct APIKeys {
        static let sinchKey = "c966416c-3817-4ba8-b84b-b72ce830c258"
    }
    
    
}
