//
//  ViewController.swift
//  wifi
//
//  Created by Michael Williams on 1/7/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("hello")
        present( UIStoryboard(name: "Status", bundle: nil).instantiateInitialViewController()!, animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

