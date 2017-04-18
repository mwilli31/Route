//
//  NetworkTableViewCell.swift
//  wifi
//
//  Created by Michael Williams on 3/26/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit

class NetworkTableViewCell: UITableViewCell {

    @IBOutlet weak var allowedLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var wifiNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        print("selected")
        // Configure the view for the selected state
    }

}
