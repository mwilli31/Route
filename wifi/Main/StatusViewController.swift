//
//  StatusViewController.swift
//  wifi
//
//  Created by Michael Williams on 1/8/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit
import NetworkExtension

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
        
//        let networkInterfaces = NEHotspotHelper.supportedNetworkInterfaces()
//        let wifi = NEHotspotNetwork()
//        
//        print(wifi)
//        print(networkInterfaces)
        
//        let st = "SSID：\(wifi.ssid)，strength：\(wifi.signalStrength)， 加密：\(wifi.isSecure)， 自动加入：\(wifi.didAutoJoin)\n"
    
 
//        var options = dictionaryWithValues(forKeys: ["kNEHotspotHelperOptionDisplayName"])
        
        let serialQueue = DispatchQueue(label: "com.route.wifi")
        
//        typealias cmd = (NEHotspotHelperCommand) -> Void
        
//        var isAvailable = NEHotspotHelper.register(options: options, queue: serialQueue, handler: cmd) {
//            var hotspotList = []
//            
//            print("inside")
//        
//            if let list = cmd.networkList, cmd.commandType == .FilterScanList {
//                var networks = [NEHotspotNetwork]()
//                for network in list {
//                    print(network.ssid)
//                    if network.SSID.hasPrefix("BTVNET") {
//                        network.setPassword("12345678")
//                        network.setConfidence(.High)
//                        networks.append(network)
//                    }
//                }
//                let response = cmd.createResponse(.Success)
//                response.setNetworkList(networks)
//                response.deliver()
//            }
//        }
        
        print("wifi test")
        
        let options: [String: NSObject] = [kNEHotspotHelperOptionDisplayName : "DropTheMike" as NSObject]
        
        //        let concurrentQueue = DispatchQueue(label: "com.route.wifi", attributes: .concurrent)
        
        let queue: DispatchQueue = DispatchQueue(label: "com.route.wifi", attributes: DispatchQueue.Attributes.concurrent)
        
        NEHotspotHelper.register(options: options, queue: queue) { (cmd: NEHotspotHelperCommand) in
            print("Received command: \(cmd.commandType.rawValue)")
            
            if cmd.commandType == NEHotspotHelperCommandType.filterScanList {
                //Get all available hotspots
                let list: [NEHotspotNetwork] = cmd.networkList!
                //Figure out the hotspot you wish to connect to
                let desiredNetwork : NEHotspotNetwork? = self.getBestScanResult(networkList: list)
                print(desiredNetwork ?? "nil")
//                if let network = desiredNetwork {
//                    network.setPassword("password") //Set the WIFI password
//                    
//                    let response = cmd.createResponse(NEHotspotHelperResult.success)
//                    
//                    response.setNetworkList([network])
//                    response.deliver() //Respond back with the filtered list
//                }
            } else if cmd.commandType == NEHotspotHelperCommandType.evaluate {
                if let network = cmd.network {
                    //Set high confidence for the network
                    network.setConfidence(NEHotspotHelperConfidence.high)
                    
                    let response = cmd.createResponse(NEHotspotHelperResult.success)
                    response.setNetwork(network)
                    response.deliver() //Respond back
                }
            } else if cmd.commandType == NEHotspotHelperCommandType.authenticate {
                //Perform custom authentication and respond back with success
                // if all is OK
                let response = cmd.createResponse(NEHotspotHelperResult.success)
                response.deliver() //Respond back
            }
            
            
        }
    }
    
    func getBestScanResult(networkList: [NEHotspotNetwork]) -> NEHotspotNetwork {
        var bestNetwork : NEHotspotNetwork? = nil
        
        //look up in comparison to local network list
        for network in networkList {
            print(network.ssid)
            //compare SSID to list SSID
            if(network.ssid == "SujusCoffee2") {
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
