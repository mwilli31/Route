//
//  AddRouteNameViewController.swift
//  wifi
//
//  Created by Sajay Shah on 4/22/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit

class AddRouteNameViewController: UIViewController {
    
    @IBOutlet weak var routeNameTextField: UITextField!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.routeNameTextField.becomeFirstResponder()
    }
    
    @IBAction func ExplainRouteName(_ sender: UIButton) {
    }
    @IBAction func routeNameTextFieldPrimaryActionTriggered(_ sender: Any) {
                self.performSegue(withIdentifier: "ConfirmLocationSegue", sender: self)
    }
    @IBAction func dismissView(_ sender: UIBarButtonItem) {
        self.routeNameTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
}
