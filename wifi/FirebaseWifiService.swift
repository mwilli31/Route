//
//  FirebaseWifiService.swift
//  wifi
//
//  Created by Michael Williams on 4/8/17.
//  Copyright © 2017 Route. All rights reserved.
//

import Foundation
import Firebase
import KeychainSwift

class FirebaseWifiService {
    
    static let sharedInstance = FirebaseWifiService()
    
    func signInFirebaseUser(email: String, password: String, vc: UIViewController, segueID: String) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (FIRUser, Error) in
            
            if(Error != nil) {
                print("Failed to sign the user in after their account creation. ", Error.debugDescription as String!)
            }
                
            else {
                print("signed in")
                DispatchQueue.main.async(execute: {
                    vc.performSegue(withIdentifier: segueID, sender: nil)
                })
            }
        })
    }
    
    func saveFirebaseCredentialsInKeychain (email: String, password: String) {
        // save the credentials to keychain
        let keychain = KeychainSwift()
        keychain.set(email, forKey: Constants.KeychainKeys.routeFirebaseEmail)
        keychain.set(password, forKey: Constants.KeychainKeys.routeFirebasePassword)
    }
    
}
