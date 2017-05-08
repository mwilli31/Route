//
//  AddNetworkViewController.swift
//  wifi
//
//  Created by Michael Williams on 4/24/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit

class AddNetworkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    @IBOutlet weak var resultsTableview: UITableView!
    var unfilteredContacts = [Contact]()
    var filteredContacts: [Contact]?
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        unfilteredContacts = try! Contact.loadFromPlist()
        filteredContacts = unfilteredContacts
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        resultsTableview.tableHeaderView = searchController.searchBar
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let contacts = filteredContacts else {
            return 0
        }
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        
        if let contacts = filteredContacts {
            let contact = contacts[indexPath.row]
            let wifiName = contact.wifiName
            cell.textLabel!.text = wifiName
        }
        
        return cell
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredContacts = unfilteredContacts.filter { Contact in
                return Contact.wifiName.lowercased().contains(searchText.lowercased())
            }
            
        } else {
            filteredContacts = unfilteredContacts
        }
        resultsTableview.reloadData()
    }
    
    @IBAction func sendMessageTest(_ sender: Any) {
        Requests.sharedInstance.askForAccess(toNetworkUUID: "DropTheMike", ownerUUID: "SI6NhWoMI9fHcGNGtXUMujaPuK23")
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension Contact {
    enum ErrorType: Error {
        case noPlistFile
        case cannotReadFile
    }
    
    /// Load all the Networks from the plist file
    static func loadFromPlist() throws -> [Contact] {
        // First we need to find the plist
        guard let file = Bundle.main.path(forResource: "Contacts", ofType: "plist") else {
            throw ErrorType.noPlistFile
        }
        
        // Then we read it as an array of dict
        guard let array = NSArray(contentsOfFile: file) as? [[String: AnyObject]] else {
            throw ErrorType.cannotReadFile
        }
        
        // Initialize the array
        var contacts: [Contact] = []
        
        // For each dictionary
        for dict in array {
            // We implement the Contact
            let contact = Contact.from(dict: dict)
            // And add it to the array
            contacts.append(contact)
        }
        
        // Return all Networks
        return contacts
    }
    
    /// Create an network corresponding to the given dict
    static func from(dict: [String: AnyObject]) -> Contact {
        let wifiName = dict["name"] as! String
        let ownerName = dict["owner"] as! String
        let ownerUUID = dict["ownerUUID"] as! String
        
        return Contact(wifiName: wifiName, ownerName: ownerName, ownerUUID: ownerUUID)
    }
}
