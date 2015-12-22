//
//  MainViewController.swift
//  Route
//
//  Created by Michael Williams on 12/22/15.
//  Copyright © 2015 Michael Williams. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {

    var myFirebase = Firebase(url:"https://routeapp.firebaseio.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        // Do any additional setup after loading the view.
        if myFirebase.authData != nil {
            // user authenticated
            print(myFirebase.authData)
        } else {
            // No user is signed in
            print("presenting login view")
            self.performSegueWithIdentifier("SignUpLogin", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
