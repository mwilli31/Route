//
//  FirebaseWifiService.swift
//  wifi
//
//  Created by Michael Williams on 4/8/17.
//  Copyright © 2017 Route. All rights reserved.
//

import Foundation
import Firebase
import KeychainSwift

class FirebaseWifiService {
    
    static let sharedInstance = FirebaseWifiService()
    
    // getPublicWifiNetworks
    func observeAllPublicWifiNetworks() {
        var databaseRef: FIRDatabaseReference!
        databaseRef = FIRDatabase.database().reference().child("/sharedPublicNetworks")
        let refHandle = databaseRef.observe(FIRDataEventType.value, with: { (snapshot) in
            let dict = snapshot.value as? [String : AnyObject] ?? [:]
            print(dict)
        })
    }
    
    // getPrivateWifiNetworks
    func observeAllAccessiblePrivateWifiNetworks() {
        let userUUID = UserService.sharedInstance.getCurrentUserUUID()

        //make sure that a user is currently logged in
        if userUUID != "" {
            var databaseRef: FIRDatabaseReference!
            databaseRef = FIRDatabase.database().reference().child("/users/" + userUUID + "/accessiblePrivateSpots")
            
            let refHandle = databaseRef.observe(FIRDataEventType.value, with: { (snapshot) in
                let spots = snapshot.value as? [String : AnyObject] ?? [:]
                
                //save to local list
                self.saveAccessibleSpots(spots: spots)
            })
            
            saveObserverHandles(handle: refHandle)
            
        }

    }
    
    private func saveObserverHandles(handle: UInt) {
        var arr = getObserverHandles()
        if (arr == nil) {
            arr = [UInt]()
        }
        arr!.append(handle)
        UserDefaults.standard.set(arr, forKey: "databaseObserverHandles")
        UserDefaults.standard.synchronize()
    }
    
    func getObserverHandles() -> [UInt]? {
        return UserDefaults.standard.object(forKey: "databaseObserverHandles") as? [UInt]
    }
    
    private func saveAccessibleSpots(spots: Dictionary<String, Any>) {
        UserDefaults.standard.set(spots, forKey: "accessibleSpots")
        UserDefaults.standard.synchronize()
    }
    
    func createWifiNetworkForTest() {
        let userUUID = UserService.sharedInstance.getCurrentUserUUID()
        let netData = [
            "ssid" : "DropTheMike",
            "password" : "woopW00P",
            "ownerID" : userUUID
        ]
        //make sure that a user is currently logged in
        if userUUID != "" {
            var databaseRef: FIRDatabaseReference!
            databaseRef = FIRDatabase.database().reference().child("/users/" + userUUID + "/accessiblePrivateSpots")
            databaseRef.child(userUUID + "_" + "DropTheMike").setValue(netData)
        }
    }
    
    // TODO: Will make sense to move this code to eventually seperate private functions to handle the posting of data
    // to multiple indexes in our system (don't worry now, since we are moving away from Firebase eventually)
    func postCurrentWifiConnectionDetails(ssid: String, networkUUID: String, timestamp: String, command: String) {
        
        let wifiConnectionDataForTimestamp = [
            "ssid" : ssid,
            "networkUUID" : networkUUID,
            "command" : command
        ]
        
        let wifiConnectionDataForNetworkUUID = [
            "ssid" : ssid,
            "timestamp" : timestamp,
            "command" : command
        ]
        
        let wifiConnectionDataForNetworkSSID = [
            "networkUUID" : networkUUID,
            "timestamp" : timestamp,
            "command" : command
        ]
        
        let userUUID = UserService.sharedInstance.getCurrentUserUUID()
        
        //make sure that a user is currently logged in
        if userUUID != "" {
            var databaseRef: FIRDatabaseReference!
            databaseRef = FIRDatabase.database().reference().child("/users/" + userUUID)
            
            let baseUserTimestampPath: String = "/connectionHistoryByTimestamp/" + timestamp
            
            let baseUserNetworkPath = "/connectionHistoryByNetworkUUID/" + networkUUID
            let key1 = databaseRef.child(baseUserNetworkPath).childByAutoId().key
            let userNetworkPath : String = baseUserNetworkPath + "/\(key1)"
            
            let baseUserSSIDPath = "/connectionHistoryByNetworkSSID/" + ssid
            let key2 = databaseRef.child(baseUserSSIDPath).childByAutoId().key
            let userSSIDPath : String = baseUserSSIDPath + "/\(key2)"
            
            let updates = [ baseUserTimestampPath : wifiConnectionDataForTimestamp,
                            userNetworkPath : wifiConnectionDataForNetworkUUID,
                            userSSIDPath : wifiConnectionDataForNetworkSSID ]
            
            databaseRef.updateChildValues(updates)
            
        }
    }
    
    func postUserAddedRoute (ssid: String, password: String, name: String, address: String) {
        let userUUID = UserService.sharedInstance.getCurrentUserUUID()
        if userUUID != "" {
            print(userUUID)
            print("POSTING")
            var databaseRef: FIRDatabaseReference!
            databaseRef = FIRDatabase.database().reference().child("/users/" + userUUID)
            let baseUserRoutePath: String = "/addedRoutes/"
            let key = databaseRef.child(baseUserRoutePath).childByAutoId().key
            let userRoutePath : String = baseUserRoutePath + "/\(key)"
            
            let addedRoute = [
                "ssid" : ssid,
                "password" : password,
                "name" : name,
                "address" : address
            ]
            
            let update = [userRoutePath : addedRoute]
            databaseRef.updateChildValues(update)
        }
    }
    
    func getNetworkAccessRequests(completion:@escaping (_ result: NSDictionary) -> Void)  {
        let userUUID = UserService.sharedInstance.getCurrentUserUUID()
        if userUUID != "" {
            print("GET: Current network access requests")
            var databaseRef: FIRDatabaseReference!
            databaseRef = FIRDatabase.database().reference().child("/users/" + userUUID)
            let requestsRef = databaseRef.child("requests")
            requestsRef.observeSingleEvent(of: .value, with: { (snapshot) in
                let requests = (snapshot.value) as? NSDictionary ?? [:]
                completion(requests)
            })
        }
    }
    
    func postNetworkAccessRequest(fromRequesterUUID: String, timestamp: String, networkUUID: String, requesterName: String, requesterPhoneNumber: String)  {
        let userUUID = UserService.sharedInstance.getCurrentUserUUID()
        if userUUID != "" {
            print("POST: Incoming network access request")
            let updates = [
                "/requesterInfo/name" : requesterName,
                "/requesterInfo/phoneNumber" : requesterPhoneNumber,
                "/networks/\(networkUUID)" : timestamp
            ]
            var databaseRef: FIRDatabaseReference!
            databaseRef = FIRDatabase.database().reference().child("/users/" + userUUID + "/requests/" + fromRequesterUUID)
            databaseRef.updateChildValues(updates)
        }
    }
    
    func purgeUserDataInclusive(fromRef: String) {
        let userUUID = UserService.sharedInstance.getCurrentUserUUID()
        if userUUID != "" {
            var databaseRef: FIRDatabaseReference!
            databaseRef = FIRDatabase.database().reference().child("/users/" + userUUID + "/" + fromRef)
            databaseRef.setValue(nil)
        }
    }
}
