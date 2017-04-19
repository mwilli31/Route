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
    
    @IBOutlet weak var timedAccessButton: UIButton!
    @IBOutlet weak var denyButton: UIButton!
    @IBOutlet weak var approveButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
//        self.denyButton.addTarget(self, action: #selector(AllowedUsers.denyAccessRequest(user:), for: .touchUpInside)
        
        
//        addTarget(self, action: #selector(ClassName.FunctionName.buttonTapped), for: .touchUpInside)
        
//     @objc    http://stackoverflow.com/questions/28894765/ios-swift-button-action-in-table-view-cell
        
    }
}

class RequestsViewController: UIViewController {
    @IBOutlet weak var requestsTableView: UITableView!
    
    var users = AllowedUsers()
    
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
        default:
            cell.username.text = self.users.currentlyAllowedUsersArray()[indexPath.row]
        }
        
        return cell
    }
}
