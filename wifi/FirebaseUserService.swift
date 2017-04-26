//
//  FirebaseWifiAnalytics.swift
//  wifi
//
//  Created by Michael Williams on 4/8/17.
//  Copyright © 2017 Route. All rights reserved.
//

import Foundation
import Firebase
import KeychainSwift

class FirebaseUserService {

    static let sharedInstance = FirebaseUserService()
    
    func getCurrentUserUUIDFirebase() -> String {
        if FIRAuth.auth()?.currentUser == nil{
            return ""
        } else {
            return (FIRAuth.auth()?.currentUser?.uid)!
        }

    }
    
    func isThereACurrentFirebaseUser() -> Bool {
        if FIRAuth.auth()?.currentUser == nil{
            return false
        } else {
            return true
        }
    }
    
    func registerNewFirebaseUser(email: String, password: String) {

        //try to sign in with the provided email & pw, to validate if the user exists yet or not
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (FIRUser, Error) in
            
            if(Error != nil) {
                print("Creating a new user since user doesn't exist. ", Error.debugDescription as String!)
                
                self.createNewFirebaseUser(email: email, password: password)
            }
                
            else {
                print("user account already exists - signing in")
                
                self.saveFirebaseCredentialsInKeychain(email: email, password: password)
            }
        })
    }
    
    func registerNewFirebaseUser(email: String, password: String, vc: UIViewController, segueID: String) {
        
        // sign in the user so when app starts again we don't show onboarding
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (FIRUser, Error) in
            
            if(Error != nil) {
                print("Creating a new user since user doesn't exist. ", Error.debugDescription as String!)
                
                self.createNewFirebaseUser(email: email, password: password, vc: vc, segueID: segueID)
            }
                
            else {
                print("user account already exists - signing in")
                
                self.saveFirebaseCredentialsInKeychain(email: email, password: password)
                
                DispatchQueue.main.async(execute: {
                    vc.performSegue(withIdentifier: segueID, sender: nil)
                })
            }
        })
    }
    
    //private so that we always use the register methods elsewhere
    private func createNewFirebaseUser(email: String, password: String) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (FIRUser, Error) in
            
            if(Error != nil) {
                print("Firebase account unsuccessful. ", Error.debugDescription as String!)
            }
            else {
                // save the credentials to keychain
                self.saveFirebaseCredentialsInKeychain(email: email, password: password)
                
                // sign in the user so when app starts again we don't show onboarding
                self.signInFirebaseUser(email: email, password: password)
            }
        })
    }
    
    //private so that we always use the register methods elsewhere
    private func createNewFirebaseUser(email: String, password: String, vc: UIViewController, segueID: String) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (FIRUser, Error) in
            
            if(Error != nil) {
                print("Firebase account unsuccessful. ", Error.debugDescription as String!)
            }
            else {
                // save the credentials to keychain
                self.saveFirebaseCredentialsInKeychain(email: email, password: password)
                
                // sign in the user so when app starts again we don't show onboarding
                self.signInFirebaseUser(email: email, password: password, vc: vc, segueID: segueID)
            }
        })
    }
    
    func setUsername(forUserUUID: String, username: String) {
        var ref: FIRDatabaseReference!
        
        ref = FIRDatabase.database().reference()
        if (FIRAuth.auth()?.currentUser) != nil {
            ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).updateChildValues(["username" : username])
        }
    }
    
    func setFCMToken(){
        let token = FIRInstanceID.instanceID().token()!
     
        var ref: FIRDatabaseReference!
        
        ref = FIRDatabase.database().reference()
        if (FIRAuth.auth()?.currentUser) != nil {
            ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).updateChildValues(["fcmToken" : token])
        }
        
    }
    
    func signInFirebaseUser(email: String, password: String) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (FIRUser, Error) in
            
            if(Error != nil) {
                print("Failed to sign the user in after their account creation. ", Error.debugDescription as String!)
            }
                
            else {
                print("signed in")
            }
        })
    }
    
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
    
    func logoutUser () {
        try! FIRAuth.auth()?.signOut()
    }
    
    func saveFirebaseCredentialsInKeychain (email: String, password: String) {
        // save the credentials to keychain
        let keychain = KeychainSwift()
        keychain.set(email, forKey: Constants.KeychainKeys.routeFirebaseEmail)
        keychain.set(password, forKey: Constants.KeychainKeys.routeFirebasePassword)
    }

}
