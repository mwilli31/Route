//
//  SignUpViewController.swift
//  Route
//
//  Created by Michael Williams on 11/24/15.
//  Copyright © 2015 Michael Williams. All rights reserved.
//

import UIKit
import libPhoneNumber_iOS
import SinchVerification

class SignUpPhoneNumberViewController: UIViewController, UITextFieldDelegate {
    
    var verification:Verification!
    var applicationKey = "60b73d3d-61e9-4ed8-857a-1addcf1a131a"
    private var phoneFormatter: NBAsYouTypeFormatter!

    @IBOutlet var phoneNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        phoneNumber.delegate = self
        phoneFormatter = NBAsYouTypeFormatter(regionCode: "US")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.phoneNumber.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func disableUI(disable:Bool) {
        if(disable) {
            phoneNumber.resignFirstResponder();
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(30*Double(NSEC_PER_MSEC)))
            
            dispatch_after(delayTime, dispatch_get_main_queue(), { () -> Void in
                self.disableUI(false);
            })

        } else {
            self.phoneNumber.becomeFirstResponder()
        }
        self.phoneNumber.enabled = !disable
    }
    
    func getVerificationCode(sender: AnyObject) {
        //self.disableUI(true);
        verification =
            SMSVerification(applicationKey:applicationKey,
                phoneNumber: phoneNumber.text!)
        verification.initiate { (success:Bool, error:NSError?) -> Void in
            self.disableUI(false)
            if (success){
                self.performSegueWithIdentifier("validatePhoneNumber", sender: sender)
            } else {
                //error
            }
        }
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range:NSRange, replacementString string: String) -> Bool {
        
        // Allow up to 18 chars
        if !(string.characters.count + range.location > 14) {
            if range.length == 0 {
                textField.text = phoneFormatter?.inputDigit(string)
            } else if range.length == 1 {
                // user pressed backspace
                textField.text = phoneFormatter?.removeLastDigit()
            } else if range.length == textField.text?.characters.count {
                // text was cleared
                phoneFormatter?.clear()
                textField.text = ""
            }
        }
        
        if (string.characters.count + range.location) == 14 {
            print("full number")
            self.getVerificationCode(phoneNumber)
        }
        
        return false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "validatePhoneNumber") {
            let enterCodeVC = segue.destinationViewController as! VerifyPhoneNumberViewController
            enterCodeVC.verification = self.verification
        }
    }

}

