//
//  AllowedUsers.swift
//  wifi
//
//  Created by Sajay Shah on 4/18/17.
//  Copyright © 2017 Route. All rights reserved.
//

import Foundation

class AllowedUsers {
    
    static let sharedInstance = AllowedUsers()
    var pendingAccessRequestUsers : [String:String]
    var currentlyAllowedUsers : [String:String]
    
    
    private init() {
        pendingAccessRequestUsers = [String:String]()
        
        pendingAccessRequestUsers["@gfrasca"] = "pending"
        pendingAccessRequestUsers["@jwilli31"] = "pending"
        pendingAccessRequestUsers["@shahfeel"] = "pending"
        
        currentlyAllowedUsers = [String:String]()
        currentlyAllowedUsers["@mrasca"] = "allowed"
        currentlyAllowedUsers["@tom_williams"] = "allowed"
        currentlyAllowedUsers["@john_doe"] = "allowed"
        
        
    }
    
    func denyAccessRequest(user : String) {
        AllowedUsers.sharedInstance.pendingAccessRequestUsers.removeValue(forKey: user)
    }

    func revokeAccessRights(user : String) {
        AllowedUsers.sharedInstance.currentlyAllowedUsers.removeValue(forKey: user)
    }
    
    func approveAccessRequest(user : String) {
        
        AllowedUsers.sharedInstance.pendingAccessRequestUsers.removeValue(forKey: user)
        AllowedUsers.sharedInstance.currentlyAllowedUsers[user] = "allowed"
        
    }
    
    func currentlyAllowedUsersArray() -> Array<String> {
        return Array(currentlyAllowedUsers.keys)
    }
    
    func pendingAccessRequestUsersArray() -> Array<String> {
        return Array(pendingAccessRequestUsers.keys)
    }
    
    
    
}