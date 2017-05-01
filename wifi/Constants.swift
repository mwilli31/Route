//
//  ConstantsAndKeys.swift
//  wifi
//
//  Created by Sajay Shah on 3/7/17.
//  Copyright © 2017 Spot. All rights reserved.
//

struct Constants {
    
    struct NotificationKeys {
        static let connectionStateNotification = "ConnectionStateNotification"
        static let connectionStateNotificationKey = "connectionState"
    }
    
    struct TimersAndDelays {
        static let discoveringSpotsTimer : Double! = 3.0
    }
    
    struct ConnectionStateMessages {
        static let needSettingsNoServiceMessage : String = "No service, open up settings to identify a Spot"
        static let discoverMessage : String = "Discovering Spots"
        static let foundSpotsMessage : String = "Discovered nearby Spots"
        static let noSpotsNearby : String = "Discovered nearby Spots"
        static let authenticateMessage : String = "Authenticating Spot"
        static let connectedMessage : String = "Connected"
    }
    
    enum ConnectionState: String {
        case NeedSettings, Discovering, NoSpotsNearby, Discovered, Authenticating, Connected, ConnectedToSSID
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
