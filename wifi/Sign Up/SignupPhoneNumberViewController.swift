//
//  SignUpViewController.swift
//  Route
//
//  Created by Michael Williams on 11/24/15.
//  Copyright © 2015 Michael Williams. All rights reserved.
//

import UIKit
import PhoneNumberKit
import SinchVerification

class SignUpPhoneNumberViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var phoneNumber: PhoneNumberTextField!
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var countryCodeText: UILabel!
    
    let phoneNumberKit = PhoneNumberKit()
    var verification:Verification!
    
    var phoneNumberMaxLength = 14;  //set as 14 for default US length, change when other country codes enabled...
    var userPhoneNumber = ""
    
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
        
        var phoneNumberSinch = "+1"
        phoneNumberSinch += self.userPhoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        self.userPhoneNumber = phoneNumberSinch


        let text = phoneNumberSinch
        
        self.verification = SMSVerification(Constants.APIKeys.sinchKey, phoneNumber: text)
        self.verification.initiate { (result: InitiationResult, error: Error?) -> Void in
            // handle outcome
            print("YO MADE IT ")
            self.performSegue(withIdentifier: "validatePhoneNumber", sender: self);
        }
        let code = ""
        self.verification.verify(code, completion: { (success: Bool, error:Error?) -> Void in
            // handle outcome
        })
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let text = textField.text else { return true }
            
        let newLength = text.utf16.count + string.utf16.count - range.length
        
        //Check to see if length is less than Max Length
        //If it exceeds or is equal that Max, then proceed to send verification
        if newLength == self.phoneNumberMaxLength {
            self.userPhoneNumber = text.utf16.description + string.utf16.description
            print(self.userPhoneNumber)
            self.view.isUserInteractionEnabled = false
            getVerificationCode()
            return true;
        } else if newLength > self.phoneNumberMaxLength {
            return false;
        } else {
            return true;
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "validatePhoneNumber") {
            
            let destinationViewController = segue.destination as! VerifyPhoneNumberViewController
            destinationViewController.phoneNumber = self.userPhoneNumber
            destinationViewController.verification = self.verification
            print("moving along...")
        }
    }

}

