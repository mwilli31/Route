//
//  NetworkTableViewCell.swift
//  wifi
//
//  Created by Michael Williams on 3/26/17.
//  Copyright © 2017 Route. All rights reserved.
//

import UIKit

class NetworkTableViewCell: UITableViewCell {
    @IBOutlet var allowedLabel: UILabel!
    @IBOutlet var activeLabel: UILabel!
    @IBOutlet var wifiNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
