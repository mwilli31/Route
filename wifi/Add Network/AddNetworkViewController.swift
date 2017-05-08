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
    let unfilteredNFLTeams = ["Bengals", "Ravens", "Browns", "Steelers", "Bears", "Lions", "Packers", "Vikings",
                              "Texans", "Colts", "Jaguars", "Titans", "Falcons", "Panthers", "Saints", "Buccaneers",
                              "Bills", "Dolphins", "Patriots", "Jets", "Cowboys", "Giants", "Eagles", "Redskins",
                              "Broncos", "Chiefs", "Raiders", "Chargers", "Cardinals", "Rams", "49ers", "Seahawks"].sorted()
    var filteredNFLTeams: [String]?
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredNFLTeams = unfilteredNFLTeams
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        resultsTableview.tableHeaderView = searchController.searchBar
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let nflTeams = filteredNFLTeams else {
            return 0
        }
        return nflTeams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        
        if let nflTeams = filteredNFLTeams {
            let team = nflTeams[indexPath.row]
            cell.textLabel!.text = team
        }
        
        return cell
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredNFLTeams = unfilteredNFLTeams.filter { team in
                return team.lowercased().contains(searchText.lowercased())
            }
            
        } else {
            filteredNFLTeams = unfilteredNFLTeams
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
