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
        // Initialization code
        
//        let gap : CGFloat = 20
//        let labelHeight: CGFloat = 30
//        let titleWidth: CGFloat = self.bounds.width - (2*gap)
//        let labelWidth: CGFloat = 100
//        let lineGap : CGFloat = 5
//        let label2Y : CGFloat = gap + labelHeight + lineGap
//        let imageSize : CGFloat = 30
//        
//        contentView.backgroundColor = .clear
//        
//        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.bounds.width, height: 100))
//        
//        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
//        whiteRoundedView.layer.masksToBounds = false
//        whiteRoundedView.layer.cornerRadius = 2.0
//        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
//        whiteRoundedView.layer.shadowOpacity = 0.2
//        
//        contentView.addSubview(whiteRoundedView)
//        contentView.sendSubview(toBack: whiteRoundedView)
//        
//        wifiNameLabel = UILabel()
//        wifiNameLabel.frame = CGRect(x:gap, y:gap, width:titleWidth, height:labelHeight)
//        wifiNameLabel.textColor = .black
//        wifiNameLabel.font = wifiNameLabel.font.withSize(24)
//        contentView.addSubview(wifiNameLabel)
//        
//        allowedLabel = UILabel()
//        allowedLabel.frame = CGRect(x: imageSize + (2*gap), y:label2Y, width:labelWidth, height:labelHeight)
//        allowedLabel.textColor = .black
//        contentView.addSubview(allowedLabel)
//        
//        activeLabel = UILabel()
//        activeLabel.frame = CGRect(x: imageSize + (5*gap) + allowedLabel.bounds.width, y:label2Y, width:labelWidth, height:labelHeight)
//        activeLabel.textColor = .black
//        contentView.addSubview(activeLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        print("selected")
        // Configure the view for the selected state
    }

}
