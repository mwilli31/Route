//
//  ProfileViewController.swift
//  wifi
//
//  Created by Michael Williams on 3/14/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet var networkTableView: UITableView!
    
    var networks: [Network] = []
    
    class func instantiateFromStoryboard() -> ProfileViewController {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! ProfileViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networks = try! Network.loadFromPlist()
        print(networks)

        self.networkTableView.dataSource = self
        self.networkTableView.delegate = self
        
        self.networkTableView.register(UITableViewCell.self, forCellReuseIdentifier: "network")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return networks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Getting the right network
//        let network = networks[indexPath.row]
        
        // Instantiate a cell
        let cellIdentifier = "network"
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath) as! NetworkTableViewCell
        
        // Adding the right informations
//        cell.textLabel?.text = network.symbol
//        cell.detailTextLabel?.text = network.name
        
        // Returning the cell
        return cell
    }
}

extension Network {
    enum ErrorType: Error {
        case noPlistFile
        case cannotReadFile
    }
    
    /// Load all the Networks from the plist file
    static func loadFromPlist() throws -> [Network] {
        // First we need to find the plist
        guard let file = Bundle.main.path(forResource: "Networks", ofType: "plist") else {
            throw ErrorType.noPlistFile
        }
        
        // Then we read it as an array of dict
        guard let array = NSArray(contentsOfFile: file) as? [[String: AnyObject]] else {
            throw ErrorType.cannotReadFile
        }
        
        // Initialize the array
        var networks: [Network] = []
        
        // For each dictionary
        for dict in array {
            // We implement the Network
            let network = Network.from(dict: dict)
            // And add it to the array
            networks.append(network)
        }
        
        // Return all Networks
        return networks
    }
    
    /// Create an network corresponding to the given dict
    static func from(dict: [String: AnyObject]) -> Network {
        let name = dict["name"] as! String
        let usersActive = dict["usersActive"] as! Int
        let usersAllowed = dict["usersAllowed"] as! Int
        let state = State(rawValue: dict["state"] as! String)!
        
        return Network(name: name, usersActive: usersActive, usersAllowed: usersAllowed, state: state)
    }
}
