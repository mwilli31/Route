//
//  VerifyPhoneNumberViewController.swift
//  Route
//
//  Created by Michael Williams on 12/13/15.
//  Copyright © 2015 Michael Williams. All rights reserved.
//

import UIKit

class VerifyPhoneNumberViewController: UIViewController, UITextFieldDelegate {

//    var verification:Verification!
//    var applicationKey = "60b73d3d-61e9-4ed8-857a-1addcf1a131a"
    var timer = Timer()
    
    var phoneNumber:String = ""
    
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
        spinner.startAnimating()
        timer.invalidate()
//        verification.verify(validateTextField.text!,
//            completion: { (success:Bool, error:NSError?) -> Void in
        let success = true
        self.spinner.stopAnimating()
                if (success) {
                    print("Verified")
                    self.performSegue(withIdentifier: "ShowCreateUsername", sender: nil)
                } else {
                    //print(error?.description)
                }
//
//        });
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        
        let newLength = text.utf16.count + string.utf16.count - range.length
        
        //Add spacing between pin numbers
        let attributedString = NSMutableAttributedString(string: textField.text!)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(20.0), range: NSRange(location: 0, length: attributedString.length))
        textField.attributedText = attributedString
        
        //If 4 numbers are input, use it to verify the phone number
        if newLength == 4 {
            timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(VerifyPhoneNumberViewController.verifyPhoneNumber), userInfo: nil, repeats: false)
            return true;
        } else if newLength > 4 {
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
