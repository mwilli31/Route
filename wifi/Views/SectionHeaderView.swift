//
//  SectionFooterView.swift
//  CascadingTableDelegate
//
//  Created by Ricardo Pramana Suranta on 10/31/16.
//  Copyright © 2016 Ricardo Pramana Suranta. All rights reserved.
//

import UIKit

class SectionFooterView: UIView {

    @IBOutlet fileprivate weak var innerView: UIView!
    @IBOutlet fileprivate weak var outerView: UIView!
	
	/**
	Preferred height for displaying this class' instance.
	
	- returns: `CGFloat` value.
	*/
	static func preferredHeight() -> CGFloat {
		return CGFloat(20.0)
	}
	
    static func view(cardColor: UIColor) -> SectionFooterView {
		
		let mainBundle = Bundle.main
		let nibs = mainBundle.loadNibNamed("SectionFooterView", owner: nil, options: nil)
		
		if let footerView = nibs?.first as? SectionFooterView {
            footerView.backgroundColor = Constants.Color.background
            footerView.outerView.backgroundColor = Constants.Color.background
            return initInnerView(footerView: footerView, backgroundColor: cardColor)
		}
		
		let footerView = SectionFooterView()
		return footerView
	}
    
    static func initInnerView(footerView: SectionFooterView, backgroundColor: UIColor) -> SectionFooterView {
        footerView.innerView.backgroundColor = backgroundColor
        footerView.innerView.round(corners: [UIRectCorner.bottomLeft, UIRectCorner.bottomRight], radius: Constants.CardView.cornerRadius)
//        footerView.innerView.layer.cornerRadius = Constants.CardView.cornerRadius
//        footerView.innerView.clipsToBounds = true
        return footerView
    }
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
}
