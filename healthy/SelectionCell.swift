//
//  SelectionCell.swift
//  healthy
//
//  Created by BanDouMacmini-1 on 16/9/19.
//  Copyright © 2016年 WHY. All rights reserved.
//

import UIKit

class SelectionCell: UITableViewCell {

    @IBOutlet weak var selectionLabel: UILabel!
    @IBOutlet weak var selectionImage: UIImageView!
    
    var isChecked: Bool = false {
        didSet {
            if self.isChecked {
                self.selectionImage.image = UIImage(named: "selection_on")
            } else {
                self.selectionImage.image = UIImage(named: "selection_off")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
