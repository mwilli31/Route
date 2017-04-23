//
//  AddRouteLocationViewController.swift
//  wifi
//
//  Created by Sajay Shah on 4/22/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit

class AddRouteLocationViewController: UIViewController {
    @IBAction func invalidLocation(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)

    }
    @IBAction func confirmLocation(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)

    }
    @IBAction func dismissView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
