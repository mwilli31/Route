//
//  LogInPhoneNumberViewController.swift
//  wifi
//
//  Created by Michael Williams on 3/6/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit
import PhoneNumberKit


class LogInPhoneNumberViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var phoneNumber: PhoneNumberTextField!
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var countryCodeText: UILabel!
    
    let phoneNumberKit = PhoneNumberKit()
    
    var phoneNumberMaxLength = 14;  //set as 14 for default US length, change when other country codes enabled...
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        Do any additional setup after loading the view, typically from a nib.
        phoneNumber.delegate = self
        self.phoneNumber.becomeFirstResponder()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getVerificationCode() {
        //spinner.startAnimating()
        print("verifying...");
        //        verification =
        //            SMSVerification(applicationKey:applicationKey,
        //                phoneNumber: phoneNumber.text!)
        //        verification.initiate { (success:Bool, error:NSError?) -> Void in
        //            self.phoneNumber.enabled = false
        //            self.spinner.stopAnimating()
        //
        let success = true;
        if (success){
            print("starting segue")
            self.performSegue(withIdentifier: "validatePhoneNumber", sender: nil)
        } else {
            //error
        }
        //        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        
        let newLength = text.utf16.count + string.utf16.count - range.length
        
        //Check to see if length is less than Max Length
        //If it exceeds or is equal that Max, then proceed to send verification
        if newLength == self.phoneNumberMaxLength {
            getVerificationCode()
            return true;
        } else if newLength > self.phoneNumberMaxLength {
            return false;
        } else {
            return true;
        }
        
        
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "validatePhoneNumber") {
            //let enterCodeVC = segue.destinationViewController as! VerifyPhoneNumberViewController
            //enterCodeVC.verification = self.verification
            
            //TODO: allow for non-US based phone numbers
            
            //let phoneUtil = NBPhoneNumberUtil()
            
            //            do {
            //                let phoneNumber: NBPhoneNumber = try phoneUtil.parse(self.phoneNumber.text!, defaultRegion: "US")
            //                let formattedString: String = try phoneUtil.format(phoneNumber, numberFormat: .E164)
            //                enterCodeVC.phoneNumber = formattedString
            //            }
            //            catch let error as NSError {
            //                print(error.localizedDescription)
            //            }
            print("moving along...")
        }
    }
    
}
