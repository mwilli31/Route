//
//  SignUpViewController.swift
//  Route
//
//  Created by Michael Williams on 11/24/15.
//  Copyright © 2015 Michael Williams. All rights reserved.
//

import UIKit
import SinchVerification

class SignUpPhoneNumberViewController: UIViewController {
    
    var verification:Verification!
    var applicationKey = "60b73d3d-61e9-4ed8-857a-1addcf1a131a"

    @IBOutlet var phoneNumber: UITextField!
    @IBOutlet var phoneNumberButton: UIButton!
    @IBOutlet var status: UILabel! 
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func disableUI(disable:Bool) {
        var alpha:CGFloat = 1.0
        if(disable) {
            alpha = 0.5;
            phoneNumber.resignFirstResponder();
            spinner.startAnimating();
            self.status.text = "";
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(30*Double(NSEC_PER_MSEC)))
            
            dispatch_after(delayTime, dispatch_get_main_queue(), { () -> Void in
                self.disableUI(false);
            })

        } else {
            self.phoneNumber.becomeFirstResponder()
            self.spinner.stopAnimating()
        }
        self.phoneNumber.enabled = !disable
        self.phoneNumberButton.enabled = !disable
        self.phoneNumberButton.alpha = alpha
        
    }
    
    @IBAction func getVerificationCodeAction(sender: AnyObject) {
        self.disableUI(true);
        verification =
            SMSVerification(applicationKey:applicationKey,
                phoneNumber: phoneNumber.text!)
        verification.initiate { (success:Bool, error:NSError?) -> Void in
            self.disableUI(false)
            if (success){
                self.performSegueWithIdentifier("validatePhoneNumber", sender: sender)
            } else {
                self.status.text = error?.description
            }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "validatePhoneNumber") {
            let enterCodeVC = segue.destinationViewController as! VerifyPhoneNumberViewController
            enterCodeVC.verification = self.verification
        }
    }

}

