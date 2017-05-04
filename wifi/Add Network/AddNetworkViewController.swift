//
//  AddNetworkViewController.swift
//  wifi
//
//  Created by Michael Williams on 4/24/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit

class AddNetworkViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func sendMessageTest(_ sender: Any) {
        Requests.sharedInstance.askForAccess(toNetworkUUID: "DropTheMike", ownerUUID: "SI6NhWoMI9fHcGNGtXUMujaPuK23")
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
