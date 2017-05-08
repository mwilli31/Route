//
//  DestinationTopPhotoCell.swift
//  CascadingTableDelegate
//
//  Created by Ricardo Pramana Suranta on 10/31/16.
//  Copyright © 2016 Ricardo Pramana Suranta. All rights reserved.
//

import UIKit

class DestinationTopPhotoCell: UITableViewCell {

	@IBOutlet fileprivate weak var photoImageView: UIImageView!
    @IBOutlet fileprivate weak var quoteLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    var firstLayout: Bool = true
	
	override func prepareForReuse() {
		super.prepareForReuse()
		self.photoImageView.image = nil
//        self.quoteLabel = nil
	}
	
	/**
	Preferred height to display this class's instance.
	
	- returns: `CGFloat` value.
	*/
	static func preferredHeight() -> CGFloat {
		
		let screenWidth = UIScreen.main.bounds.width
		let ratio = CGFloat(194.0 / 375.0)
		
		return screenWidth * ratio
	}
	
	/**
	Configures this instance using passed `image`.
	
	- parameter image: `UIImage` optional.
	*/
    func configure(image: UIImage?, quote: String?) {
        photoImageView.image = image

        if firstLayout {
            let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.extraLight))
            visualEffectView.alpha = 0.8
            
            visualEffectView.frame = photoImageView.bounds
            visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            photoImageView.addSubview(visualEffectView)

            firstLayout = false
        }

        logoImageView.image = UIImage(named: "logo")

        guard quote != nil else {
            return
        }
        quoteLabel.text = "\"" + quote! + "\"" + "\n\n" + "-Sir Williams"
        quoteLabel.textColor = Constants.Color.mainText
        
	}
    
}
