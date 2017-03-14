//
//  RequestsViewController.swift
//  wifi
//
//  Created by Michael Williams on 3/14/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit

class RequestsViewController: UIViewController {
    
    class func instantiateFromStoryboard() -> RequestsViewController {
        let storyboard = UIStoryboard(name: "Requests", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! RequestsViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
