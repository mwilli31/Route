//
//  RequestsViewController.swift
//  wifi
//
//  Created by Michael Williams on 3/14/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit
import Foundation

class RequestTableViewCell: UITableViewCell {
    
    var allowAccessClosure : (() -> Void)? = nil
    
    var declineAccessClosure : (() -> Void)? = nil
    
    @IBOutlet weak var username: UILabel!
    
    @IBAction func allowAccess(_ sender: UIButton) {
        if let allowAccess = self.allowAccessClosure {
            allowAccess()
        }
    }
    
    @IBAction func declineAccess(_ sender: UIButton) {
        if let declineAccess = self.declineAccessClosure {
            declineAccess()
        }
    }
}

class RequestsViewController: UIViewController {
    @IBOutlet weak var requestsTableView: UITableView!
    
    @IBAction func allowAccess(_ sender: UIButton) {
        
    }
    var userRequests = RouteAC.sharedInstance
    var userRequestsKeys = [String]()
    
    let routeACListNotification = Notification.Name(rawValue:Constants.NotificationKeys.routeACListNotification)
    
    class func instantiateFromStoryboard() -> RequestsViewController {
        let storyboard = UIStoryboard(name: "Requests", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! RequestsViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        userRequestsKeys = userRequests.pendingAccessRequestUsersArray()
        self.requestsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let nc = NotificationCenter.default
        nc.addObserver(forName:routeACListNotification, object:nil, queue:nil, using:catchRouteACListNotification)
        

    }
    
    @IBAction func denyButtonAction(_ sender: UIButton) {
        print("Deny request")
//        self.requestsTableView.reloadData()
    }
    
    @IBAction func approveButtonAction(_ sender: UIButton) {
//        print("approve request")
//        self.requestsTableView.reloadData()
    }
    
    func catchRouteACListNotification(notification:Notification) -> Void {
        print("Received notification that Route AC List has been updated.")
        userRequestsKeys = userRequests.pendingAccessRequestUsersArray()
        self.requestsTableView.reloadData()
    }
}

extension RequestsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userRequestsKeys.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "request") as! RequestTableViewCell
        let fromRequesterUUID = self.userRequestsKeys[indexPath.row]
        let userRequest = self.userRequests.accessRequests[fromRequesterUUID]
        cell.username.text = userRequest?.requesterInfo["name"]
        
        cell.allowAccessClosure = {
            print("approve")
        }
        
        cell.declineAccessClosure = {
            RouteAC.sharedInstance.declineAccessRequest(fromRequesterUUID: fromRequesterUUID)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(userRequestsKeys[indexPath.row])
    }

}
