//
//  Route.swift
//  wifi
//
//  Created by Sajay Shah on 4/25/17.
//  Copyright © 2017 Route. All rights reserved.
//


/** This class is a lazy way to get around passing parameters from view controller to view controller.
 *  dispose() of the singleton when the Route has been published.
 */

// TODO: Add support for Route location

import Foundation
class Route {
    
    static var sharedInstance = Route()
    
    var credentials : [String:String]
    
    private init () {
        credentials = [String:String]()
        credentials["ssid"] = ""
        credentials["password"] = ""
        credentials["name"] = ""
    }
    
    func setSSID(ssid: String) {
        Route.sharedInstance.credentials["ssid"] = ssid
    }
    
    func getSSID() -> String {
        return Route.sharedInstance.credentials["ssid"]!
    }
    
    func setPassword(password: String) {
        Route.sharedInstance.credentials["password"] = password
    }
    
    func getPassword() -> String {
        return Route.sharedInstance.credentials["password"]!
    }
    
    func setName(name: String) {
        Route.sharedInstance.credentials["name"] = name
    }
    
    func getName() -> String {
        return Route.sharedInstance.credentials["name"]!
    }
}
