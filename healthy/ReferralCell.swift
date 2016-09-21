//
//  ReferralCell.swift
//  healthy
//
//  Created by BanDouMacmini-1 on 16/9/21.
//  Copyright © 2016年 WHY. All rights reserved.
//

import UIKit

class ReferralCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
