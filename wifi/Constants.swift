//
//  ConstantsAndKeys.swift
//  wifi
//
//  Created by Sajay Shah on 3/7/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit

struct Constants {
    
    struct NotificationKeys {
        static let connectionStateNotification = "ConnectionStateNotification"
        static let connectionStateNotificationKey = "connectionState"
        static let connectionStateMessageNotificationKey = "connectionStateMessage"
        
        static let locationNotification = "ConnectionStateNotification"
        static let locationNotificationKey = "location"
        static let locationPostalCodeNotificationKey = "postalCode"
        
        static let routeACListNotification = "RouteACListNotification"
//        static let connectionStateNotificationKey = "connectionState"
//        static let connectionStateMessageNotificationKey = "connectionStateMessage"

    }
    
    struct TimersAndDelays {
        static let discoveringRoutesTimer : Double! = 3.0
    }
    
    struct ConnectionStateMessages {
        static let needSettingsNoServiceMessage : String = "No service, open up settings to identify a Spot"
        static let discoverMessage : String = "Discovering Spots"
        static let foundRoutesMessage : String = "Discovered nearby Spots"
        static let noRoutesNearby : String = "Discovered nearby Spots"
        static let authenticateMessage : String = "Authenticating Spot"
        static let connectedMessage : String = "Connected"
    }
    
    enum ConnectionState: String {
        case NeedSettings, Discovering, NoRoutesNearby, Discovered, Authenticating, Connected, ConnectedToSSID
    }
    
    struct Color {
        static let blueGrayDark = UIColor(r: 47, g: 69, b: 92)
        static let blueMediumMetallic = UIColor(r: 1, g: 159, b: 196)
        static let blueLight = UIColor(r: 30, g: 207, b: 248)
        static let tealGreen = UIColor(r: 52, g: 245, b: 198)
        static let offWhite = UIColor(r: 238, g: 242, b: 245)
        static let white = UIColor.white
        
        static let button = Color.blueGrayDark
        static let buttonText = Color.white
        static let background = Color.offWhite
        static let mainText = Color.blueGrayDark
        static let headerBackground = Color.blueMediumMetallic
        static let headerText = Color.white
        static let headerIndicator = Color.blueLight
        
        //cards colors
        //main card type
        static let mainCardBackground = Color.white
        static let mainCardText = Color.blueGrayDark

        //status discovering card type
        static let connectionStateCardBackground = Color.blueLight
        static let connectionStateCardText = Color.blueGrayDark
        
        //map card type
        static let mapCardBackground = Color.tealGreen
        static let mapCardText = Color.blueGrayDark

    }
    
    struct CardView {
        static let cornerRadius = CGFloat(10.0)
        static let mapZoom = 300.0

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

extension UIColor {
    convenience init(r: Int, g: Int, b: Int) {
        let cR : CGFloat = pow(pow((CGFloat(r)/255.0),2.2), 0.4545)
        let cG : CGFloat = pow(pow((CGFloat(g)/255.0),2.2), 0.4545)
        let cB : CGFloat = pow(pow((CGFloat(b)/255.0),2.2), 0.4545)
        self.init(red: CGFloat(cR), green: CGFloat(cG), blue: CGFloat(cB), alpha: 1.0)
    }
}
