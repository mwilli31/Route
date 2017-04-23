//
//  AddRouteSSIDViewController.swift
//  wifi
//
//  Created by Sajay Shah on 4/22/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit

class AddRouteSSIDViewController: UIViewController {
    @IBOutlet weak var SSIDTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.SSIDTextField.becomeFirstResponder()
    }
    
    @IBAction func ExplainSSID(_ sender: UIButton) {
    }
    @IBAction func SSIDTextFieldPrimaryActionTriggered(_ sender: Any) {
        
        print("DONE")
        self.performSegue(withIdentifier: "EnterPasswordSegue", sender: self)
    }
    @IBAction func dismissView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
