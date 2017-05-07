//
//  LocationManager.swift
//  wifi
//
//  Created by Michael Williams on 5/6/17.
//  Copyright © 2017 Route. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance = LocationManager()
    
    private let locationManager = CLLocationManager()
    let locationNotification = Notification.Name(rawValue:Constants.NotificationKeys.locationNotification)
    let nc = NotificationCenter.default
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startGettingLocation() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if error != nil {
                print ("Error in finding location while location services were enabled.")
            } else {
                if let place = placemark?[0] {
                    if place.locality != nil {
                        
                        let ext = place.addressDictionary!["PostCodeExtension"] as! String
                        let index = ext.index(ext.startIndex, offsetBy: 2)
                        let extendedPostalCode = place.postalCode! + "-" + ext.substring(to: index)
                        
                        self.publishLocationNotification(location: location, postalCode: extendedPostalCode)
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error finding location")
    }
    
    private func publishLocationNotification(location: CLLocation, postalCode: String) {
        self.nc.post(name:self.locationNotification,
                     object: nil,
                     userInfo:[
                        Constants.NotificationKeys.locationNotificationKey:location,
                        Constants.NotificationKeys.locationPostalCodeNotificationKey:postalCode
            ])
        
    }


}
