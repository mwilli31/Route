//
//  RequestsViewController.swift
//  wifi
//
//  Created by Michael Williams on 3/14/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit

class RequestTableViewCell: UITableViewCell {
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userPicture: UIImageView!
}

class RequestsViewController: UIViewController {
    @IBOutlet weak var requestsTableView: UITableView!
    
    var users = AllowedUsers.sharedInstance
    
    let sectionHeaders = ["Access Requests", "Allowed Users"]
    
    class func instantiateFromStoryboard() -> RequestsViewController {
        let storyboard = UIStoryboard(name: "Requests", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! RequestsViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.requestsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func denyButtonAction(_ sender: UIButton) {
        let usernameLabel = resolveUsernameLabelFromCell(sender: sender)
        
        switch usernameLabel.tag {
        case 0:
            users.denyAccessRequest(user: usernameLabel.text!)
            self.requestsTableView.reloadData()
        case 1:
            users.revokeAccessRights(user: usernameLabel.text!)
            self.requestsTableView.reloadData()
        default: break
        }
    }
    
    @IBAction func approveButtonAction(_ sender: UIButton) {
        users.approveAccessRequest(user: resolveUsernameLabelFromCell(sender: sender).text!)
        self.requestsTableView.reloadData()
    }
    
    @IBAction func timedAccessAction(_ sender: UIButton) {
        print("Oh implement me baby")
    }
    
    func resolveUsernameLabelFromCell(sender: UIButton) -> UILabel {
        var ancestor = sender.superview
        while ancestor != nil && !(ancestor! is RequestTableViewCell) {
            ancestor = ancestor?.superview
        }
        let cell = ancestor as! RequestTableViewCell
        return cell.username
    }
}

extension RequestsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return users.pendingAccessRequestUsersArray().count
        default:
            return users.currentlyAllowedUsersArray().count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionHeaders.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionHeaders[section]
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "request") as! RequestTableViewCell
        
        switch indexPath.section {
        case 0:
            cell.username.text = self.users.pendingAccessRequestUsersArray()[indexPath.row]
            cell.username.tag = indexPath.section
        default:
            cell.username.text = self.users.currentlyAllowedUsersArray()[indexPath.row]
            cell.username.tag = indexPath.section
        }
        
        return cell
    }

}
