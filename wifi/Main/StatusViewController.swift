//
//  StatusViewController.swift
//  wifi
//
//  Created by Michael Williams on 1/8/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit
import Lottie
import MapKit
import CascadingTableDelegate

class StatusViewController: UIViewController {
    @IBOutlet var wifiSettingsButton: UIButton!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var mapView: MKMapView!

    // MARK: -Cascade View Setup
    @IBOutlet weak fileprivate var tableView: UITableView!
    fileprivate let refreshControl = UIRefreshControl()
    fileprivate let viewModel = DestinationViewModel()
    fileprivate var rootDelegate: CascadingRootTableDelegate?

    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let connectionStateNotification = Notification.Name(rawValue:Constants.NotificationKeys.connectionStateNotification)
    let locationNotification = Notification.Name(rawValue:Constants.NotificationKeys.locationNotification)
    let nc = NotificationCenter.default
    
    let animationView = LOTAnimationView(name: "RouteLogoBlueBlinking")

    class func instantiateFromStoryboard() -> StatusViewController {
        let storyboard = UIStoryboard(name: "Status", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! StatusViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initColors()
        
        nc.addObserver(forName:connectionStateNotification, object:nil, queue:nil, using:catchConnectionStateNotification)
        nc.addObserver(forName:locationNotification, object:nil, queue:nil, using:catchLocationNotification)
        
        self.activityIndicator.hidesWhenStopped=true

        ConnectionStateHelper.sharedInstance.updateCurrentState()
        
        WifiService.sharedInstance.observeAllPublicWifiNetworks()
        WifiService.sharedInstance.observeAllAccessiblePrivateWifiNetworks()
        
        self.initCascadeView()
    }
    
    private func initCascadeView() {
        updateTitle()
        
        configureRefreshControl()
//        configureNavBarStyle()
        
        createRootDelegate()
    }
    
    private func initAnimationView() {
        self.animationView?.frame = CGRect(x: self.view.bounds.width/2 - 70, y: 80, width: 140, height: 140)
        self.animationView?.contentMode = .scaleAspectFill
        self.animationView?.loopAnimation = true
        self.view.addSubview(animationView!)
    }
    
    private func initColors() {
        self.view.backgroundColor = Constants.Color.blueGrayDark
        self.statusLabel.textColor = Constants.Color.mainText
        self.wifiSettingsButton.backgroundColor = Constants.Color.button
        self.wifiSettingsButton.setTitleColor(Constants.Color.buttonText, for: UIControlState.normal)
    }
    
    func stopActivityIndicator() {
        self.activityIndicator.stopAnimating()
//        self.animationView?.pause()
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
            LocationManager.sharedInstance.startGettingLocation()
//            self.perform(#selector(self.stopActivityIndicator), with: nil, afterDelay: TimeInterval(Constants.TimersAndDelays.discoveringRoutesTimer))
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
    
    func catchLocationNotification(notification:Notification) -> Void {
        print("Catch notification")
        
        guard let userInfo = notification.userInfo,
            let location = userInfo[Constants.NotificationKeys.locationNotificationKey] as? CLLocation,
            let postalCode = userInfo[Constants.NotificationKeys.locationPostalCodeNotificationKey] as? String else {
                print("No userInfo found in notification")
                return
        }
        print(postalCode)
        
        self.centerMapOnLocation(location: location)
        self.stopActivityIndicator()
        
    }
    
    let regionRadius: CLLocationDistance = 300
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
//        let userLocationAnnotation = MKPointAnnotation()
//        userLocationAnnotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
//        mapView.addAnnotation(userLocationAnnotation)
    }
    
    
    // MARK: - Private methods
    
    fileprivate func updateTitle() {
        title = viewModel.destinationTitle ?? "Destination"
    }
    
    fileprivate func configureRefreshControl() {
        
        refreshControl.addTarget(self, action: #selector(StatusViewController.refreshData), for: .valueChanged)
        
        tableView.addSubview(refreshControl)
    }
    
    fileprivate func configureNavBarStyle() {
        
        let navigationBar = self.navigationController?.navigationBar
        
        navigationBar?.barTintColor = UIColor.cst_DarkBlueGrey
        navigationBar?.tintColor = UIColor.white
        navigationBar?.titleTextAttributes = [ NSForegroundColorAttributeName: UIColor.white ]
        
        navigationBar?.barStyle = .black
    }
    
    fileprivate func createRootDelegate() {
        
        // Feel free to remove, add, copy, or change this array's value. The rootTableDelegate will do the heavy-lifting and display the correct result for you :)
        
        let childDelegates: [CascadingTableDelegate] = [
            DestinationHeaderSectionDelegate(viewModel: viewModel),
            DestinationInfoMapSectionDelegate(viewModel: viewModel),
            DestinationInfoListSectionDelegate(viewModel: viewModel),
            DestinationReviewRatingSectionDelegate(viewModel: viewModel),
            DestinationReviewUserSectionDelegate(viewModel: viewModel)
        ]
        
        rootDelegate = CascadingRootTableDelegate(
            childDelegates: childDelegates,
            tableView: tableView
        )
    }
    
    @objc fileprivate func refreshData() {
        
        viewModel.refreshData { [weak self] in
            self?.updateTitle()
            self?.stopRefreshControl()
        }
        
        if refreshControl.isRefreshing {
            return
        }
        
        startRefreshControl()
    }
    
    fileprivate func startRefreshControl() {
        
        tableView.showRefreshControl()
        
        refreshControl.layoutIfNeeded()
        refreshControl.beginRefreshing()
        refreshControl.isHidden = false
    }
    
    fileprivate func stopRefreshControl() {
        
        let delayTime = DispatchTime.now() + 1.5
        let dispatchQueue = DispatchQueue.global(qos: .userInitiated)
        
        dispatchQueue.asyncAfter(deadline: delayTime) {
            
            DispatchQueue.main.async(execute: {
                self.refreshControl.endRefreshing()
            })
        }
    }

}
