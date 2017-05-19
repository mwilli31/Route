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
    @IBOutlet weak var username: UILabel!
}

class RequestsViewController: UIViewController {
    @IBOutlet weak var requestsTableView: UITableView!
    
    var users = RouteAC.sharedInstance
    
    let routeACListNotification = Notification.Name(rawValue:Constants.NotificationKeys.routeACListNotification)
    
    class func instantiateFromStoryboard() -> RequestsViewController {
        let storyboard = UIStoryboard(name: "Requests", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! RequestsViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let nc = NotificationCenter.default
        nc.addObserver(forName:routeACListNotification, object:nil, queue:nil, using:catchRouteACListNotification)
    }
    
    @IBAction func denyButtonAction(_ sender: UIButton) {
        print("Deny request")
//        users.denyAccessRequest(user: resolveUsernameLabelFromCell(sender: sender).text!)
//        self.requestsTableView.reloadData()
    }
    
    @IBAction func approveButtonAction(_ sender: UIButton) {
        print("approve request")
//        users.approveAccessRequest(user: resolveUsernameLabelFromCell(sender: sender).text!)
//        self.requestsTableView.reloadData()
    }
    
    func resolveUsernameLabelFromCell(sender: UIButton) -> UILabel {
        var ancestor = sender.superview
        while ancestor != nil && !(ancestor! is RequestTableViewCell) {
            ancestor = ancestor?.superview
        }
        let cell = ancestor as! RequestTableViewCell
        return cell.username
    }
    
    func catchRouteACListNotification(notification:Notification) -> Void {
        print("Received notification that Route AC List has been updated.")
        self.requestsTableView.reloadData()
    }
}

extension RequestsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.accessRequests.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "request") as! RequestTableViewCell
        cell.username.text = self.users.pendingAccessRequestUsersArray()[indexPath.row]
        return cell
    }

}
