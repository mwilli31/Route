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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
