//
//  VerifyPhoneNumberViewController.swift
//  Route
//
//  Created by Michael Williams on 12/13/15.
//  Copyright © 2015 Michael Williams. All rights reserved.
//

import UIKit
import FirebaseAuth
import KeychainSwift
import SinchVerification


class VerifyPhoneNumberViewController: UIViewController, UITextFieldDelegate {

//    var verification:Verification!
//    var applicationKey = "60b73d3d-61e9-4ed8-857a-1addcf1a131a"
//    var timer = Timer()
    
    var phoneNumber:String = ""
    let pinLength = 4
    var userPin = ""
    
    var verification:Verification!
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var validateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validateTextField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.validateTextField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func verifyPhoneNumber() {

        print("Users PN: ", self.phoneNumber)
        print("Users PIN: ", self.userPin)
        self.verification.verify(self.userPin,
                            completion: { (success:Bool, error:Error?) -> Void in
                                if (success) {
                                    print("Verified phone number")
                                    self.createFirebaseUser()
                                    
                                }
                                else {
                                    print("Unable to verify phone number")
                                }
        });

        
        
    }
    
    func createFirebaseUser() {
        // generating ghetto password. +14087070430 --> 0430+1408707
        let index = self.phoneNumber.index(self.phoneNumber.startIndex, offsetBy: 8)
        let pw = self.phoneNumber.substring(from: index) + self.phoneNumber.substring(to: index)
        UserService.sharedInstance.createUserByPhonenumber(phonenumber: self.phoneNumber, password: pw,  vc: self, segueID: "ShowCreateUsername")
        
//        FIRAuth.auth()?.createUser(withEmail: self.phoneNumber+"@example.com", password: userPassword, completion: { (FIRUser, Error) in
//            
//            if(Error != nil) {
//                print("Firebase account unsuccessful. ", Error.debugDescription as String!)
//            }
//            else {
//                // save the credentials to keychain
//                let keychain = KeychainSwift()
//                keychain.set(userPassword, forKey: Constants.KeychainKeys.routeFirebasePassword)
//                keychain.set(self.phoneNumber+"@example.com", forKey: Constants.KeychainKeys.routeFirebaseEmail)
//                
//                // sign in the user so when app starts again we don't show onboarding
//                FIRAuth.auth()?.signIn(withEmail: self.phoneNumber+"@example.com", password: userPassword, completion: { (FIRUser, Error) in
//                    
//                    if(Error != nil) {
//                        print("Signing the user in after their account creation failed. ", Error.debugDescription as String!)
//                    }
//                        
//                    else {
//                        DispatchQueue.main.async(execute: {
//                            self.performSegue(withIdentifier: "ShowCreateUsername", sender: nil)
//                        })
//                    }
//                })
//            }
//        })
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        
        let newLength = text.utf16.count + string.utf16.count - range.length
        
        //Check to see if length is less than Max Length
        //If it exceeds or is equal that Max, then proceed to send verification
        if newLength == self.pinLength {
            self.userPin = text.utf16.description + string.utf16.description
            print(self.userPin)
            verifyPhoneNumber()
            return true;
        } else if newLength > self.pinLength {
            return false;
        } else {
            return true;
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ShowCreateUsername") {
            //let destinationViewController = segue.destinationViewController as! CreateUsernameViewController
            //destinationViewController.phoneNumber = self.phoneNumber
        }
    }

}
