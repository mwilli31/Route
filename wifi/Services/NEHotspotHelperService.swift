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
    let connectionStateNotification = Notification.Name(rawValue:Constants.NotificationKeys.connectionStateNotification)
    let nc = NotificationCenter.default
    
    func createNEHotspotHelperQueue () {
        
        let options: [String: NSObject] = [kNEHotspotHelperOptionDisplayName : "Route Network" as NSObject]
        
        let queue: DispatchQueue = DispatchQueue(label: "com.route.wifi", attributes: DispatchQueue.Attributes.concurrent)
        
        print("NEHotspotHelper queue has begun")
        
        NEHotspotHelper.register(options: options, queue: queue) { (cmd: NEHotspotHelperCommand) in
            print("Received command: \(cmd.commandType.rawValue)")
            let epoch = String(Int(Date().timeIntervalSince1970.rounded()))

            if cmd.commandType == NEHotspotHelperCommandType.filterScanList {
                self.handleWifiScan(cmd: cmd)
            } else if cmd.commandType == NEHotspotHelperCommandType.evaluate {
                self.handleEvaluate(cmd: cmd)
            } else if cmd.commandType == NEHotspotHelperCommandType.authenticate {
                print("connected...")
                self.handleAuthenticateAndMaintain(cmd: cmd, timestampEpoch: epoch)
                WifiService.sharedInstance.postCurrentWifiConnectionDetails(ssid: (cmd.network?.ssid)!, networkUUID: (cmd.network?.bssid)!, timestamp: epoch, command: "authenticate")
            } else if cmd.commandType == NEHotspotHelperCommandType.maintain {
                print("maintaining")
                self.handleAuthenticateAndMaintain(cmd: cmd, timestampEpoch: epoch)
                WifiService.sharedInstance.postCurrentWifiConnectionDetails(ssid: (cmd.network?.ssid)!, networkUUID: (cmd.network?.bssid)!, timestamp: epoch, command: "maintain")
            }
        }
    }
    
    private func handleWifiScan(cmd: NEHotspotHelperCommand) {
        //Get all available hotspots
        let list: [NEHotspotNetwork] = cmd.networkList!

        //Figure out the hotspot you wish to connect to
//        let desiredNetworks : [NEHotspotNetwork?] = WifiService.sharedInstance.getMatchingNetworks(forNetworkList: list)
        let desiredNetwork : NEHotspotNetwork? = self.getBestScanResult(networkList: list)
        
        if let network = desiredNetwork {
            print("setting password: ")
            network.setPassword("woopWOOP92") //Set the WIFI password
            
            let response = cmd.createResponse(NEHotspotHelperResult.success)
            
            response.setNetworkList([network])
            response.deliver() //Respond back with the filtered list
            
            self.postNetworkConnectionStateNotification(state: Constants.ConnectionState.Discovered ,connectionStateMessage: Constants.ConnectionStateMessages.foundRoutesMessage)
        }
    }
    
    private func handleEvaluate(cmd: NEHotspotHelperCommand) {
        print("evaluating/authenticating...")
        
        if let network = cmd.network {
            print(network)
            //Set high confidence for the network
            network.setConfidence(NEHotspotHelperConfidence.high)
            
            let response = cmd.createResponse(NEHotspotHelperResult.success)
            response.setNetwork(network)
            response.deliver() //Respond back
            
            // notify view controllers
            self.postNetworkConnectionStateNotification(state: Constants.ConnectionState.Authenticating, connectionStateMessage: Constants.ConnectionStateMessages.authenticateMessage)
        }

    }
    
    private func handleAuthenticateAndMaintain(cmd: NEHotspotHelperCommand, timestampEpoch: String) {

        let connectedMessage = Constants.ConnectionStateMessages.connectedMessage +  " To " + (cmd.network?.ssid)!
        self.postNetworkConnectionStateNotification(state: Constants.ConnectionState.ConnectedToSSID, connectionStateMessage: connectedMessage)
        ConnectionStateHelper.sharedInstance.saveConnectedNetwork(withSSID: cmd.network!.ssid, networkUUID: cmd.network!.bssid, timestamp: timestampEpoch)
        ConnectionStateHelper.sharedInstance.save(state: Constants.ConnectionState.ConnectedToSSID.rawValue)
        
        let response = cmd.createResponse(NEHotspotHelperResult.success)
        response.deliver()
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
    
    private func postNetworkConnectionStateNotification(state: Constants.ConnectionState, connectionStateMessage: String) {
        self.nc.post(name:self.connectionStateNotification,
                     object: nil,
                     userInfo:[
                        Constants.NotificationKeys.connectionStateNotificationKey:state,
                        Constants.NotificationKeys.connectionStateMessageNotificationKey:connectionStateMessage
            ])
        
    }
 
}
