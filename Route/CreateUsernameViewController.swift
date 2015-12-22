//
//  CreateUsernameViewController.swift
//  Route
//
//  Created by Michael Williams on 12/21/15.
//  Copyright © 2015 Michael Williams. All rights reserved.
//

import UIKit
import Firebase

class CreateUsernameViewController: UIViewController, UITextFieldDelegate {
    
    // Create a reference to a Firebase location
    var myFirebase = Firebase(url:"https://routeapp.firebaseio.com")
    
    var timer = NSTimer()
    
    var phoneNumber: String = ""
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.usernameTextField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createUser(usernameStr: String) {
        spinner.startAnimating()
        timer.invalidate()

        let usernameEmail: String = usernameStr + "@route.app"
        
        myFirebase.createUser(usernameEmail, password: self.phoneNumber,
            withValueCompletionBlock: { error, authData in
                
                self.spinner.stopAnimating()

                if error != nil {
                    print(error)
                } else {
                    
                    let uid = authData["uid"] as! String
                    print("Successfully created user account with uid: \(uid)")
                    
                    self.storeCurrentUserInfo(uid, phonenumber: self.phoneNumber, username: usernameStr)
                    
                    self.performSegueWithIdentifier("SuccessView", sender: nil)
                }
        })
        
    }
    
    func storeCurrentUserInfo(uid: String, phonenumber: String, username: String) {
        let newUser = CurrentUser(username: username, phonenumber: phonenumber, authorizationData: uid)
        
        print(newUser)
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(newUser)
        
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "CurrentUser")
        
        getCurrentUserInfo()
    }
    
    func getCurrentUserInfo() {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("CurrentUser") as? NSData {
            let currentUser = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! CurrentUser
            print(currentUser.phonenumber)
            print(currentUser.username)
            print(currentUser.authorizationData)
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        //textField code
        
        createUser(usernameTextField.text!)
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
