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
    
    func createUser(username_str: String) {
        spinner.startAnimating()
        timer.invalidate()
        print(username_str)
        print(self.phoneNumber)
        
        myFirebase.createUser(username_str, password: self.phoneNumber,
            withValueCompletionBlock: { error, result in
                
                self.spinner.stopAnimating()

                if error != nil {
                    print(error)
                } else {
                    let uid = result["uid"] as? String
                    print("Successfully created user account with uid: \(uid)")
                    self.performSegueWithIdentifier("SuccessView", sender: nil)
                }
        })
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        //textField code
        
        createUser(usernameTextField.text! + "@route.com")
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
