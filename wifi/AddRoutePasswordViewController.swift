//
//  AddRoutePasswordViewController.swift
//  wifi
//
//  Created by Sajay Shah on 4/22/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit

class AddRoutePasswordViewController : UIViewController {
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.passwordTextField.becomeFirstResponder()
    }
    
    @IBAction func passwordTextFieldPrimaryActionTriggered(_ sender: Any) {
                self.performSegue(withIdentifier: "AddRouteNameSegue", sender: self)
    }
    @IBAction func ExplainPassword(_ sender: UIButton) {
    }
    @IBAction func dismissView(_ sender: UIBarButtonItem) {
        self.passwordTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
}
