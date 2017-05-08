//
//  SectionHeaderView.swift
//  CascadingTableDelegate
//
//  Created by Ricardo Pramana Suranta on 10/31/16.
//  Copyright © 2016 Ricardo Pramana Suranta. All rights reserved.
//

import UIKit

class SectionHeaderView: UIView {

	@IBOutlet fileprivate weak var headerLabel: UILabel!
    @IBOutlet fileprivate weak var innerView: UIView!
    @IBOutlet fileprivate weak var outerView: UIView!
	
	/**
	Preferred height for displaying this class' instance.
	
	- returns: `CGFloat` value.
	*/
	static func preferredHeight() -> CGFloat {
		return CGFloat(40)
	}
	
    static func view(headerText: String, cardColor: UIColor) -> SectionHeaderView {
		
		let mainBundle = Bundle.main
		let nibs = mainBundle.loadNibNamed("SectionHeaderView", owner: nil, options: nil)
		
		if let headerView = nibs?.first as? SectionHeaderView {
            headerView.backgroundColor = Constants.Color.background
            headerView.headerLabel.textColor = Constants.Color.mapCardText
			headerView.configure(headerText: headerText)
            headerView.outerView.backgroundColor = Constants.Color.background
            return initInnerView(headerView: headerView, backgroundColor: cardColor)
		}
		
		let headerView = SectionHeaderView()
		headerView.configure(headerText: headerText)
		
		return headerView
	}
    
    static func initInnerView(headerView: SectionHeaderView, backgroundColor: UIColor) -> SectionHeaderView {
        headerView.innerView.backgroundColor = backgroundColor
        headerView.innerView.round(corners: [UIRectCorner.topLeft, UIRectCorner.topRight], radius: Constants.CardView.cornerRadius)
//        headerView.innerView.layer.cornerRadius = Constants.CardView.cornerRadius
//        headerView.innerView.clipsToBounds = true
        return headerView
    }
	
	override func awakeFromNib() {
		super.awakeFromNib()
		headerLabel?.text = nil
	}
	
	func configure(headerText: String) {
		headerLabel?.text = headerText
	}
}
