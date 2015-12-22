//
//  CurrentUser.swift
//  Route
//
//  Created by Michael Williams on 12/21/15.
//  Copyright © 2015 Michael Williams. All rights reserved.
//
import UIKit

class CurrentUser: NSObject, NSCoding {
    var username: String
    var phonenumber: String
    var authorizationData: String
    
    init(username: String, phonenumber: String, authorizationData: String) {
        self.username = username
        self.phonenumber = phonenumber
        self.authorizationData = authorizationData
        
        super.init()
    }
    
    // MARK: NSCoding
    
    required convenience init?(coder aDecoder: NSCoder) {
        let username = aDecoder.decodeObjectForKey("username") as! String
        let phonenumber = aDecoder.decodeObjectForKey("phonenumber") as! String
        let authorizationData = aDecoder.decodeObjectForKey("authorizationData") as! String
        
        // Must call designated initilizer.
        self.init(username: username, phonenumber: phonenumber, authorizationData: authorizationData)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(username, forKey: "username")
        aCoder.encodeObject(phonenumber, forKey: "phonenumber")
        aCoder.encodeObject(authorizationData, forKey: "authorizationData")
    }
}