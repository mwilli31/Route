//
//  SignUpViewController.swift
//  Route
//
//  Created by Michael Williams on 11/24/15.
//  Copyright © 2015 Michael Williams. All rights reserved.
//

import UIKit
import PhoneNumberKit


class SignUpPhoneNumberViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var phoneNumber: PhoneNumberTextField!
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var countryCodeText: UILabel!
    
    let phoneNumberKit = PhoneNumberKit()
    var phoneNumberMaxLength = 14;  //set as 14 for default US length, change when other country codes enabled...

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        Do any additional setup after loading the view, typically from a nib.
        phoneNumber.delegate = self
        phoneNumberKit.countryCode(for: "US")
        self.phoneNumber.becomeFirstResponder()

    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getVerificationCode(sender: AnyObject) {
        spinner.startAnimating()
        print("verifying...");
//        verification =
//            SMSVerification(applicationKey:applicationKey,
//                phoneNumber: phoneNumber.text!)
//        verification.initiate { (success:Bool, error:NSError?) -> Void in
//            self.phoneNumber.enabled = false
//            self.spinner.stopAnimating()
//
//            if (success){
//                self.performSegueWithIdentifier("validatePhoneNumber", sender: sender)
//            } else {
//                //error
//            }
//        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let text = textField.text else { return true }
            
        let newLength = text.utf16.count + string.utf16.count - range.length
        return newLength <= self.phoneNumberMaxLength // Bool
    
        
        // Allow up to 18 chars
//        if !(string.characters.count + range.location > 14) {
////            if range.length == 0 {
////                textField.text = string;
////               // textField.text = phoneFormatter?.inputDigit(string)
////            } else if range.length == 1 {
////                textField.text = string;
////                // user pressed backspace
////                //textField.text = phoneFormatter?.removeLastDigit()
////            } else if range.length == textField.text?.characters.count {
////
////                // text was cleared
////                // phoneFormatter?.clear()
////                textField.text = ""
////            }
//        }
//        
//        if (string.characters.count + range.location) == 14 {
//            print("full number")
//           // self.getVerificationCode(phoneNumber)
//        }
//        
//        return false
    }
    
   // override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if(segue.identifier == "validatePhoneNumber") {
//            let enterCodeVC = segue.destinationViewController as! VerifyPhoneNumberViewController
//            enterCodeVC.verification = self.verification
//            
//            //TODO: allow for non-US based phone numbers
//            
//            let phoneUtil = NBPhoneNumberUtil()
//            
//            do {
//                let phoneNumber: NBPhoneNumber = try phoneUtil.parse(self.phoneNumber.text!, defaultRegion: "US")
//                let formattedString: String = try phoneUtil.format(phoneNumber, numberFormat: .E164)
//                enterCodeVC.phoneNumber = formattedString
//            }
//            catch let error as NSError {
//                print(error.localizedDescription)
//            }
//            
//        }
   // }

}

