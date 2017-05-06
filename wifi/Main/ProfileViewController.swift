//
//  ProfileViewController.swift
//  wifi
//
//  Created by Michael Williams on 3/14/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var networkTableView: UITableView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var addSpotButton: UIButton!
    
    var networks: [Network] = []
    
    class func instantiateFromStoryboard() -> ProfileViewController {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! ProfileViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networks = try! Network.loadFromPlist()
        print(networks)

        self.initColors()
        
        self.networkTableView.dataSource = self
        self.networkTableView.delegate = self
        self.networkTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func initColors() {
        self.view.backgroundColor = Constants.Color.background
        self.usernameLabel.textColor = Constants.Color.mainText
        self.addSpotButton.backgroundColor = Constants.Color.button
        self.addSpotButton.setTitleColor(Constants.Color.buttonText, for: UIControlState.normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return networks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // the cell height in storyboard is (this_value - 20). This is what creates the cell spacing
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Getting the right network
        let network = networks[indexPath.row]
    
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Instantiate a cell
        let cellIdentifier = "NetworkCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! NetworkTableViewCell
        
        // Adding the right informations
        cell.wifiNameLabel.text = network.name
        cell.activeLabel.text = String(network.usersActive)  + " Active"
        cell.allowedLabel.text = String(network.usersAllowed) + " Allowed"
        
        cell.wifiNameLabel.textColor = Constants.Color.white
        cell.activeLabel.textColor = Constants.Color.white
        cell.allowedLabel.textColor = Constants.Color.white
        cell.backgroundView?.backgroundColor = Constants.Color.blueGrayDark
        
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
