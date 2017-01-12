//
//  StatusViewController.swift
//  wifi
//
//  Created by Michael Williams on 1/8/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit

class StatusViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

//                
//        if let list = cmd.networkList where cmd.commandType == .FilterScanList {
//            var networks = [NEHotspotNetwork]()
//            for network in list {
//                if network.SSID.hasPrefix("BTVNET") {
//                    network.setPassword("12345678")
//                    network.setConfidence(.High)
//                    networks.append(network)
//                }
//            }
//            let response = cmd.createResponse(.Success)
//            response.setNetworkList(networks)  
//            response.deliver()  
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkWifiStatus() -> Bool {
        var wifiConnected = false;
        
        wifiConnected = true;
        
        return wifiConnected;
    }
    
    
}
