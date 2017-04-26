//
//  SignUpCompleteViewController.swift
//  Route
//
//  Created by Michael Williams on 12/15/15.
//  Copyright © 2015 Michael Williams. All rights reserved.
//

import UIKit

class SignUpCompleteViewController: UIViewController {
    
    @IBAction func getStarted(_ sender: UIButton) {
        present( UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!, animated: true, completion: nil)
    }
}
