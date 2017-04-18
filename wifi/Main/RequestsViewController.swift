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
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
    
    // Swipe to show options not working because of PagingMenuViewController?
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let button1 = UITableViewRowAction.init(style: .default, title: "Action 1") { (action, IndexPath) in
            print("HELLO")
        }
        let button2 = UITableViewRowAction.init(style: .default, title: "Action 2") { (action, IndexPath) in
            print("BYE")
        }
        
        return [button1, button2]

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Instantiate a cell
        let cellIdentifier = "request"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! RequestTableViewCell
        
        // Adding the right information
        cell.username.text = "Sajay"

        // Returning the cell
        return cell
    }
}
