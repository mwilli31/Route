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
    
    private init() {
        // TODO: Retrieve from Firebase
        pendingAccessRequestUsers = [String:String]()
        pendingAccessRequestUsers["@gfrasca"] = "pending"
        pendingAccessRequestUsers["@jwilli31"] = "pending"
        pendingAccessRequestUsers["@shahfeel"] = "pending"
    }

    func denyAccessRequest(user : String) {
        AllowedUsers.sharedInstance.pendingAccessRequestUsers.removeValue(forKey: user)
    }

    func approveAccessRequest(user : String) {
        AllowedUsers.sharedInstance.pendingAccessRequestUsers.removeValue(forKey: user)
        // TODO: Firebase activity
    }
    
    func pendingAccessRequestUsersArray() -> Array<String> {
        return Array(pendingAccessRequestUsers.keys)
    }
}
