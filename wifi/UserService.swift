//
//  CurrentUser.swift
//  wifi
//
//  Created by Michael Williams on 4/7/17.
//  Copyright © 2017 Route. All rights reserved.
//

import Foundation
import UIKit
import KeychainSwift

class UserService {
    
    static let sharedInstance = UserService()
    
    let keychain = KeychainSwift()
    
    func isThereACurrentUser () -> Bool {
        return FirebaseUserService.sharedInstance.isThereACurrentFirebaseUser()
    }
    
    func getCurrentUserUUID () -> String {
        return FirebaseUserService.sharedInstance.getCurrentUserUUIDFirebase()
    }
    
    func loginUserByDeviceUUID () {

        if let email = keychain.get("email") {
            let pw = keychain.get("password")
            FirebaseUserService.sharedInstance.signInFirebaseUser(email: email, password: pw!)
        } else {
            let deviceUUID = UIDevice.current.identifierForVendor!.uuidString
            let email = deviceUUID + "@example.com"
            let pw = deviceUUID
            FirebaseUserService.sharedInstance.signInFirebaseUser(email: email, password: pw)
        }
    }
    
    func logoutUser () {
        FirebaseUserService.sharedInstance.logoutUser()
    }
    
    func createUserByDeviceUUID () {
        let deviceUUID = UIDevice.current.identifierForVendor!.uuidString
        
                //deviceUUID+"@example.com"  deviceUUID
        let email = deviceUUID + "@example.com"
        let pw = deviceUUID
        FirebaseUserService.sharedInstance.registerNewFirebaseUser(email: email, password: pw)
    }

    func createUserByDeviceUUID (vc: UIViewController, segueID: String) {
        let deviceUUID = UIDevice.current.identifierForVendor!.uuidString
        
        //deviceUUID+"@example.com"  deviceUUID
        let email = deviceUUID + "@example.com"
        let pw = deviceUUID
        FirebaseUserService.sharedInstance.registerNewFirebaseUser(email: email, password: pw, vc: vc, segueID: segueID)
    }
    
    func createUserByPhonenumber (phonenumber: String, vc: UIViewController, segueID: String) {
        //deviceUUID+"@example.com"  deviceUUID
        let email = phonenumber + "@example.com"
        let pw = phonenumber
        FirebaseUserService.sharedInstance.registerNewFirebaseUser(email: email, password: pw, vc: vc, segueID: segueID)
    }
    
    func createUserByPhonenumber (phonenumber: String, password: String, vc: UIViewController, segueID: String) {
        //deviceUUID+"@example.com"  deviceUUID
        let email = phonenumber + "@example.com"
        FirebaseUserService.sharedInstance.registerNewFirebaseUser(email: email, password: password, vc: vc, segueID: segueID)
    }
    
    func setUsername(username: String) {
        FirebaseUserService.sharedInstance.setUsername(forUserUUID: self.getCurrentUserUUID(), username: username)
    }
    
    func setPushNotificationToken() {
        FirebaseUserService.sharedInstance.setFCMToken()
    }
}
