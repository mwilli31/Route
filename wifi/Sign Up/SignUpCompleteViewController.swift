//
//  SignUpCompleteViewController.swift
//  Route
//
//  Created by Michael Williams on 12/15/15.
//  Copyright © 2015 Michael Williams. All rights reserved.
//

import UIKit

class SignUpCompleteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func getStarted(_ sender: UIButton) {
        
        
        present( UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!, animated: true, completion: nil)
        
        
    }
}
