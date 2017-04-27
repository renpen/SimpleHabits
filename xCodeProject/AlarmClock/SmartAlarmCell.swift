//
//  SmartAlarmCell.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 27.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit

class SmartAlarmCell: CustomViewCell{

    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
