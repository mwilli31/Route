//
//  AddRouteLocationViewController.swift
//  wifi
//
//  Created by Sajay Shah on 4/22/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit
import CoreLocation

class AddRouteLocationViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var beforeAddressLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var cityStateLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getLocation()
    }
    
    
    @IBAction func invalidLocation(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)

    }
    @IBAction func confirmLocation(_ sender: UIButton) {
        addRoute()
        self.dismiss(animated: true, completion: nil)

    }
    @IBAction func dismissView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addRoute() {
        let routeSSID = Route.sharedInstance.getSSID()
        let routePassword = Route.sharedInstance.getPassword()
        let routeName = Route.sharedInstance.getName()
        let routeAddress = Route.sharedInstance.getAddress()
        WifiService.sharedInstance.postUserAddedRoute(ssid: routeSSID, password: routePassword, name: routeName, address: routeAddress)
    }
    
    func getLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]

        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if error != nil {
                print ("Error in finding location while location services were enabled.")
                Route.sharedInstance.setAddress(address: "none")
            } else {
                if let place = placemark?[0] {
                    if place.subThoroughfare != nil {
                        let streetAddress = place.subThoroughfare! + " " + place.thoroughfare!
                        let cityState = place.locality! + ", " + place.administrativeArea!
                        
                        Route.sharedInstance.setAddress(address: streetAddress + " " + cityState)
                        
                        self.streetLabel.text = streetAddress
                        self.cityStateLabel.text = cityState
                    }
                }
            }
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Route.sharedInstance.setAddress(address: "none")
        beforeAddressLabel.text = "Unable to find location. \n Press any button to continue."
    }
}
