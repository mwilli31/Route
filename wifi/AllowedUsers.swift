//
//  AllowedUsers.swift
//  wifi
//
//  Created by Sajay Shah on 4/18/17.
//  Copyright © 2017 Route. All rights reserved.
//

import Foundation

class AllowedUsers {
    
    var pendingAccessRequestUsers : [String:String]
    var currentlyAllowedUsers : [String:String]
    
    init() {

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
        
        self.pendingAccessRequestUsers.removeValue(forKey: user)
    
    }
    
    func approveAccessRequest(user : String) {
        
        self.pendingAccessRequestUsers.removeValue(forKey: user)
        self.currentlyAllowedUsers[user] = "allowed"
        
    }
    
    func currentlyAllowedUsersArray() -> Array<String> {
        return Array(currentlyAllowedUsers.keys)
    }
    
    func pendingAccessRequestUsersArray() -> Array<String> {
        return Array(pendingAccessRequestUsers.keys)
    }
    
    
    
}
