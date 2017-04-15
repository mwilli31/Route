//
//  StatusViewController.swift
//  wifi
//
//  Created by Michael Williams on 1/8/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit

class StatusViewController: UIViewController {
    @IBOutlet var wifiSettingsButton: UIButton!
    @IBOutlet var statusLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let connectionStateNotification = Notification.Name(rawValue:Constants.NotificationKeys.connectionStateNotification)
    
    class func instantiateFromStoryboard() -> StatusViewController {
        let storyboard = UIStoryboard(name: "Status", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! StatusViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let nc = NotificationCenter.default
        nc.addObserver(forName:connectionStateNotification, object:nil, queue:nil, using:catchConnectionStateNotification)
        
        self.wifiSettingsButton.isHidden=true
        self.activityIndicator.startAnimating()
        self.perform(#selector(self.stopActivityIndicator), with: nil, afterDelay: 2)
        

    }
    
    func stopActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.hidesWhenStopped=true
        self.wifiSettingsButton.isHidden=false
        
    }
    
    @IBAction func openWifiSettingsPage(_ sender: Any) {
        print("opening wifi page")
                
        guard let settingsUrl = URL(string:"App-Prefs:root=WIFI") else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") // Prints true
            })
        }

    }
    
    func catchConnectionStateNotification(notification:Notification) -> Void {
        print("Catch notification")
        
        guard let userInfo = notification.userInfo,
            let connectionState = userInfo[Constants.NotificationKeys.connectionStateNotificationKey] as? String else {
                print("No userInfo found in notification")
                return
        }
        
        //update label
        DispatchQueue.main.async(execute: {
            self.statusLabel.text = connectionState
        })
        

    }
}
