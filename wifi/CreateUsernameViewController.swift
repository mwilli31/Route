//
//  CreateUsernameViewController.swift
//  Route
//
//  Created by Michael Williams on 12/21/15.
//  Copyright © 2015 Michael Williams. All rights reserved.
//

import UIKit
//import Firebase

class CreateUsernameViewController: UIViewController, UITextFieldDelegate {
    
    // Create a reference to a Firebase location
//    var myFirebase = Firebase(url:"https://routeapp.firebaseio.com")
//    
//    let MyKeychainWrapper = KeychainWrapper()
    
    var timer = Timer()
    
    var phoneNumber: String = ""
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        usernameTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.usernameTextField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createUser(usernameStr: String) {
//        spinner.startAnimating()
//        timer.invalidate()
//
//        let usernameEmail: String = usernameStr + "@route.app"
//        
//        myFirebase.createUser(usernameEmail, password: self.phoneNumber,
//            withValueCompletionBlock: { error, authData in
//                
//                self.spinner.stopAnimating()
//
//                if error != nil {
//                    print(error)
//                } else {
//                    
//                    let uid = authData["uid"] as! String
//                    print("Successfully created user account with uid: \(uid)")
//                    
//                    self.storeCurrentUserInfoLocally(uid, phonenumber: self.phoneNumber, username: usernameStr)
//                    
//                    self.storeNewUserInfoToDatabase(uid, phonenumber: self.phoneNumber, username: usernameStr)
//                    
//                    self.performSegueWithIdentifier("SetProfilePictureView", sender: nil)
//                }
//        })
        
    }
    
    func storeNewUserInfoToDatabase(uid: String, phonenumber: String, username: String) {
//        let un = "@" + username
//        
//        //For now the newUser will only have the following information saved
//        //We will add more data on as it comes available, like profile photo etc.
//        let newUser = [
//            "phoneNumber": phonenumber,
//            "displayName": un
//        ]
//        
//        // Create a child path with a key set to the uid underneath the "users" node
//        // This creates a URL path like the following:
//        //  - https://<YOUR-FIREBASE-APP>.firebaseio.com/users/<uid>
//        myFirebase.childByAppendingPath("users").childByAppendingPath(uid).setValue(newUser)
//        
//        // Add this new user to the overall list of users
//        // First index by Username in RouteUsersUN
//        let usersUNRef = myFirebase.childByAppendingPath("RouteUsersUN").childByAppendingPath(un)
//        let userPN = ["uid": uid, "phonenumber": phonenumber]
//        usersUNRef.setValue(userPN, withCompletionBlock: {
//            (error:NSError?, ref:Firebase!) in
//            if (error != nil) {
//                print(error)
//            } else {
//                print("Data saved successfully!")
//            }
//        })
//        
//        // Second index by Phonenumber in RouteUsersPN
//        let usersPNRef = myFirebase.childByAppendingPath("RouteUsersPN").childByAppendingPath(phonenumber)
//        let userUN = ["uid": uid, "username": un]
//        usersPNRef.setValue(userUN, withCompletionBlock: {
//            (error:NSError?, ref:Firebase!) in
//            if (error != nil) {
//                print(error)
//            } else {
//                print("Data saved successfully!")
//            }
//        })
    }
    
    func storeCurrentUserInfoLocally(uid: String, phonenumber: String, username: String) {
//        let newUser = CurrentUser(username: username, phonenumber: phonenumber, authorizationData: uid)
//        
//        print(newUser)
//        let pass: String = phonenumber
//        
//        let hasLoginKey = NSUserDefaults.standardUserDefaults().boolForKey("hasLoginKey")
//        if hasLoginKey == false {
//            MyKeychainWrapper.mySetObject(pass, forKey:kSecValueData)
//            MyKeychainWrapper.writeToKeychain()
//            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasLoginKey")
//            NSUserDefaults.standardUserDefaults().synchronize()
//        }
//        
//        let data = NSKeyedArchiver.archivedDataWithRootObject(newUser)
//        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "CurrentUser")
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        //textField code
        
//        createUser(usernameTextField.text!)
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
