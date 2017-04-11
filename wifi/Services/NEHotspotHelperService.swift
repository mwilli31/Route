//
//  NEHotspotHelperService.swift
//  wifi
//
//  Created by Michael Williams on 4/10/17.
//  Copyright © 2017 Route. All rights reserved.
//

import Foundation
import NetworkExtension

class NEHotspotHelperService {
    
    static let sharedInstance = NEHotspotHelperService()
    
    func createNEHotspotHelperQueue () {
        
        let options: [String: NSObject] = [kNEHotspotHelperOptionDisplayName : "Route Network" as NSObject]
        
        let queue: DispatchQueue = DispatchQueue(label: "com.route.wifi", attributes: DispatchQueue.Attributes.concurrent)
        
        print("NEHotspotHelper queue has begun")
        
        NEHotspotHelper.register(options: options, queue: queue) { (cmd: NEHotspotHelperCommand) in
            print("Received command: \(cmd.commandType.rawValue)")
            let epoch = String(Int(Date().timeIntervalSince1970.rounded()))

            if cmd.commandType == NEHotspotHelperCommandType.filterScanList {
                //Get all available hotspots
                let list: [NEHotspotNetwork] = cmd.networkList!
                //Figure out the hotspot you wish to connect to
                let desiredNetwork : NEHotspotNetwork? = self.getBestScanResult(networkList: list)
                
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
                WifiService.sharedInstance.currentWifiConnectionDetailsPost(ssid: (cmd.network?.ssid)!, networkUUID: "1234", timestamp: epoch)
                response.deliver() //Respond back
            } else if cmd.commandType == NEHotspotHelperCommandType.maintain {
                print("maintaining")
                let response = cmd.createResponse(NEHotspotHelperResult.success)
                WifiService.sharedInstance.currentWifiConnectionDetailsPost(ssid: (cmd.network?.ssid)!, networkUUID: "1234", timestamp: epoch)
                response.deliver()
            }
            
        }
    }
    
    private func getBestScanResult(networkList: [NEHotspotNetwork]) -> NEHotspotNetwork {
        var bestNetwork : NEHotspotNetwork? = nil
        
        //look up in comparison to local network list
        for network in networkList {
            //compare SSID to list SSID
            if(network.ssid == "DropTheMike-5G") {
                print("matched")
                bestNetwork = network
            }
        }
        
        return bestNetwork!
    }
 
}
