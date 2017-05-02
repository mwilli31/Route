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
    
    let connectionStateNotification = Notification.Name(rawValue:Constants.NotificationKeys.connectionStateNotification)
    
    class func instantiateFromStoryboard() -> RequestsViewController {
        let storyboard = UIStoryboard(name: "Requests", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! RequestsViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let nc = NotificationCenter.default
        nc.addObserver(forName:connectionStateNotification, object:nil, queue:nil, using:catchConnectionStateNotification)
    }
    
    @IBAction func denyButtonAction(_ sender: UIButton) {
        users.denyAccessRequest(user: resolveUsernameLabelFromCell(sender: sender).text!)
        self.requestsTableView.reloadData()
    }
    
    @IBAction func approveButtonAction(_ sender: UIButton) {
        users.approveAccessRequest(user: resolveUsernameLabelFromCell(sender: sender).text!)
        self.requestsTableView.reloadData()
    }
    
    func resolveUsernameLabelFromCell(sender: UIButton) -> UILabel {
        var ancestor = sender.superview
        while ancestor != nil && !(ancestor! is RequestTableViewCell) {
            ancestor = ancestor?.superview
        }
        let cell = ancestor as! RequestTableViewCell
        return cell.username
    }
    
    func catchConnectionStateNotification(notification:Notification) -> Void {
        print("Catch notification in req vc")
        guard let userInfo = notification.userInfo,
            let connectionState = userInfo["update"] as? Bool
            else {
                print("Fuck sajayn No userInfo found in notification")
                return
        }
        if connectionState {
            self.requestsTableView.reloadData()
        }
    }
}

extension RequestsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(users.accessRequestsByUserID.count)
        return users.accessRequestsByUserID.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "request") as! RequestTableViewCell
        cell.username.text = self.users.pendingAccessRequestUsersArray()[indexPath.row]
        return cell
    }

}
