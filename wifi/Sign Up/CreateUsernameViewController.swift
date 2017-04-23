//
//  CreateUsernameViewController.swift
//  Route
//
//  Created by Michael Williams on 12/21/15.
//  Copyright © 2015 Michael Williams. All rights reserved.
//

import UIKit

class CreateUsernameViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var usernameTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        self.usernameTextField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        UserService.sharedInstance.setUsername(username: self.usernameTextField.text!)
        self.performSegue(withIdentifier: "SuccessView", sender: self)
        return true
    }
}
