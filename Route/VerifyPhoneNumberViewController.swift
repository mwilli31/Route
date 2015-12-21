//
//  VerifyPhoneNumberViewController.swift
//  Route
//
//  Created by Michael Williams on 12/13/15.
//  Copyright © 2015 Michael Williams. All rights reserved.
//

import UIKit
import SinchVerification

class VerifyPhoneNumberViewController: UIViewController, UITextFieldDelegate {

    var verification:Verification!
    var applicationKey = "60b73d3d-61e9-4ed8-857a-1addcf1a131a"
    var timer = NSTimer()
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var validateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validateTextField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.validateTextField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func verifyPhoneNumber() {
        spinner.startAnimating()
        timer.invalidate()
        verification.verify(validateTextField.text!,
            completion: { (success:Bool, error:NSError?) -> Void in
                self.spinner.stopAnimating()
                if (success) {
                    print("Verified")
                    self.performSegueWithIdentifier("CreateUsernameView", sender: nil)
                } else {
                    print(error?.description)
                }
                
        });
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range:NSRange, replacementString string: String) -> Bool {
        
        if (string.characters.count + range.location) == 4 {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target:self, selector: Selector("verifyPhoneNumber"), userInfo: nil, repeats: false)

        }
        
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
