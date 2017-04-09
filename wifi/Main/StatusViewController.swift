//
//  StatusViewController.swift
//  wifi
//
//  Created by Michael Williams on 1/8/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit
import NetworkExtension
import Firebase

class StatusViewController: UIViewController {
    
    class func instantiateFromStoryboard() -> StatusViewController {
        let storyboard = UIStoryboard(name: "Status", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! StatusViewController
    }
    
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
        
        wifiConnectionTest()
    }
    
//    class func register(options: [String : NSObject]? = nil,
//                        queue: DispatchQueue,
//                        handler: @escaping NEHotspotHelperHandler) -> Bool {
//        
//        
//    }
    
    func wifiConnectionTest(){
        
        print("wifi test")
        
        let options: [String: NSObject] = [kNEHotspotHelperOptionDisplayName : "Route Network" as NSObject]
        
        
        let queue: DispatchQueue = DispatchQueue(label: "com.route.wifi", attributes: DispatchQueue.Attributes.concurrent)
        
        print("queue has begun")
        
        
        FIRAnalytics.logEvent(withName: "queue-start", parameters: [
            "name": "queue-start" as NSObject,
            "full_text": "started HotspotHelper" as NSObject
            ])
        
        NEHotspotHelper.register(options: options, queue: queue) { (cmd: NEHotspotHelperCommand) in
            print("Received command: \(cmd.commandType.rawValue)")
            
            let name = "Received Command"
            let text = "Received command: \(cmd.commandType.rawValue)"
            
            FIRAnalytics.logEvent(withName: "NEHotspotHelper", parameters: [
                "name": name as NSObject,
                "full_text": text as NSObject
                ])
            
            if cmd.commandType == NEHotspotHelperCommandType.filterScanList {
                //Get all available hotspots
                let list: [NEHotspotNetwork] = cmd.networkList!
                //Figure out the hotspot you wish to connect to
                let desiredNetwork : NEHotspotNetwork? = self.getBestScanResult(networkList: list)
//                print(desiredNetwork ?? "nil")
                
                if let network = desiredNetwork {
                    print("setting password")
                    network.setPassword("woopWOOP92") //Set the WIFI password
                    
                    let response = cmd.createResponse(NEHotspotHelperResult.success)
                    
                    response.setNetworkList([network])
                    response.deliver() //Respond back with the filtered list
                }
            } else if cmd.commandType == NEHotspotHelperCommandType.evaluate {
                print("evaluating...")

                if let network = cmd.network {
                    print(network)
                    //Set high confidence for the network
                    network.setConfidence(NEHotspotHelperConfidence.high)
                    
                    let response = cmd.createResponse(NEHotspotHelperResult.success)
                    response.setNetwork(network)
                    response.deliver() //Respond back
                }
            } else if cmd.commandType == NEHotspotHelperCommandType.authenticate {
                //Perform custom authentication and respond back with success
                // if all is OK
                print("authenticating...")
                let response = cmd.createResponse(NEHotspotHelperResult.success)
                response.deliver() //Respond back
            }
            
            
        }
    }
    
    func getBestScanResult(networkList: [NEHotspotNetwork]) -> NEHotspotNetwork {
        var bestNetwork : NEHotspotNetwork? = nil
        
        //look up in comparison to local network list
        for network in networkList {
            //print(network.ssid)
            //compare SSID to list SSID
            if(network.ssid == "DropTheMike-5G") {
                print("matched")
                bestNetwork = network
            }
        }
        
        return bestNetwork!
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
