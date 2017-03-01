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
    
    required convenience init(coder aDecoder: NSCoder) {
        let username = aDecoder.decodeObject(forKey: "username") as! String
        let phonenumber = aDecoder.decodeObject(forKey: "phonenumber") as! String
        let authorizationData = aDecoder.decodeObject(forKey: "authorizationData") as! String
        
        // Must call designated initilizer.
        self.init(username: username, phonenumber: phonenumber, authorizationData: authorizationData)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(username, forKey: "username")
        aCoder.encode(phonenumber, forKey: "phonenumber")
        aCoder.encode(authorizationData, forKey: "authorizationData")
    }
}
