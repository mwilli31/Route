//
//  LaunchMainViewController.swift
//  wifi
//
//  Created by Michael Williams on 1/7/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit

class LaunchMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // You gotta sign the user out for testing purposes.
        // UserService.sharedInstance.logoutUser()
        
        //Start the HotspotHelperQueue
        NEHotspotHelperService.sharedInstance.createNEHotspotHelperQueue()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // You gotta sign the user out for testing purposes. Make sure you delete from Firebase as well.
        //        try! FIRAuth.auth()?.signOut()
        
        // Check if user is logged in...
        if !UserService.sharedInstance.isThereACurrentUser() {
            // segue to sign up/login view controller
            print("User is not signed in / account does not exist")
            self.performSegue(withIdentifier: "SignUpViewControllerSegue", sender: nil)
        } else {
            print("User is signed in")
            self.performSegue(withIdentifier: "PagingMenuViewControllerSegue", sender: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

