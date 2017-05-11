//
//  ConnectionStateCell.swift
//  CascadingTableDelegate
//
//  Created by Ricardo Pramana Suranta on 11/1/16.
//  Copyright © 2016 Ricardo Pramana Suranta. All rights reserved.
//

import UIKit
import MapKit

class ConnectionStateCell: UITableViewCell {
    @IBOutlet weak var wrapperView: UIView!
	
	/// Preferred height to show this class' instance.
	static func preferredHeight() -> CGFloat {
		return CGFloat(30.0)
	}
	
	func configure() {
		wrapperView.backgroundColor = Constants.Color.connectionStateCardBackground
	}
	
}
