//
//  ProfileViewController.swift
//  wifi
//
//  Created by Michael Williams on 3/14/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    class func instantiateFromStoryboard() -> ProfileViewController {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! ProfileViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
