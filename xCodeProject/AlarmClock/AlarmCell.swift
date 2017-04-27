//
//  AlarmCell.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 24.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit

class AlarmCell: CustomViewCell {
    
    @IBOutlet weak var wakeUpTimeLabel: UILabel!
    @IBOutlet weak var alarmNameLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        changeColor()
    }
    
    
    
}
