//
//  StatusViewController.swift
//  wifi
//
//  Created by Michael Williams on 1/8/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit
import Lottie

class StatusViewController: UIViewController {
    @IBOutlet var wifiSettingsButton: UIButton!
    @IBOutlet var statusLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let connectionStateNotification = Notification.Name(rawValue:Constants.NotificationKeys.connectionStateNotification)
    let animationView = LOTAnimationView(name: "RouteLogoBlueBlinking")

    class func instantiateFromStoryboard() -> StatusViewController {
        let storyboard = UIStoryboard(name: "Status", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! StatusViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let nc = NotificationCenter.default
        nc.addObserver(forName:connectionStateNotification, object:nil, queue:nil, using:catchConnectionStateNotification)
        
        self.animationView?.frame = CGRect(x: self.view.bounds.width/2 - 70, y: 80, width: 140, height: 140)
        self.animationView?.contentMode = .scaleAspectFill
        self.animationView?.loopAnimation = true
        self.view.addSubview(animationView!)
        self.activityIndicator.hidesWhenStopped=true

        ConnectionStateHelper.sharedInstance.updateCurrentState()
        
        WifiService.sharedInstance.observeAllPublicWifiNetworks()
        WifiService.sharedInstance.observeAllAccessiblePrivateWifiNetworks()
        
    }
    
    func stopActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.animationView?.pause()
        self.wifiSettingsButton.isHidden=false
        
        //update label
        DispatchQueue.main.async(execute: {
            self.statusLabel.text = Constants.ConnectionStateMessages.foundRoutesMessage
        })
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
            let connectionState = userInfo[Constants.NotificationKeys.connectionStateNotificationKey] as? Constants.ConnectionState,
            let connectionStateMessage = userInfo[Constants.NotificationKeys.connectionStateMessageNotificationKey] as? String else {
                print("No userInfo found in notification")
                return
        }
        
        
        if(connectionState == Constants.ConnectionState.Discovering)   {
            self.wifiSettingsButton.isHidden=true
            self.activityIndicator.hidesWhenStopped=true
            self.activityIndicator.startAnimating()
            self.animationView?.play()
            self.perform(#selector(self.stopActivityIndicator), with: nil, afterDelay: TimeInterval(Constants.TimersAndDelays.discoveringRoutesTimer))
        } else if connectionState == Constants.ConnectionState.Discovered {
            self.wifiSettingsButton.isHidden=false
        } else {
            self.wifiSettingsButton.isHidden=true
        }
        
        //update label
        DispatchQueue.main.async(execute: {
            self.statusLabel.text = connectionStateMessage
        })
        

    }
}
