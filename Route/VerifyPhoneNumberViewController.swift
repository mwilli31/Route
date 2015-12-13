//
//  VerifyPhoneNumberViewController.swift
//  Route
//
//  Created by Michael Williams on 12/13/15.
//  Copyright © 2015 Michael Williams. All rights reserved.
//

import UIKit
import SinchVerification

class VerifyPhoneNumberViewController: UIViewController {

    var verification:Verification!
    var applicationKey = "60b73d3d-61e9-4ed8-857a-1addcf1a131a";
    
    @IBOutlet var pinNumber: UITextField!
    @IBOutlet var verifyButton: UIButton!
    @IBOutlet var status: UILabel!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func verifyPhoneNumber(sender: AnyObject) {
        spinner.startAnimating();
        verifyButton.enabled = false;
        status.text  = "";
        pinNumber.enabled = false;
        verification.verify(pinNumber.text!,
            completion: { (success:Bool, error:NSError?) -> Void in
                self.spinner.stopAnimating();
                self.verifyButton.enabled = true;
                self.pinNumber.enabled = true;
                if (success) {
                    self.status.text = "Verified";
                } else {
                    self.status.text = error?.description;
                }
        });
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
