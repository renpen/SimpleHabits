//
//  AlarmCell.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 24.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit

class AlarmCell: UITableViewCell {
    
    @IBOutlet weak var wakeUpTimeLabel: UILabel!
    @IBOutlet weak var alarmNameLabel: UILabel!
    @IBOutlet weak var activeSwitch: UISwitch!
    @IBOutlet weak var smartImage: UIImageView!
    
    var onColor = UIColor(red:1.00, green:0.53, blue:0.04, alpha:1.0)
    var offColor = UIColor(red:0.67, green:0.67, blue:0.67, alpha:1.0)
    
    @IBAction func switchChanged(_ sender: Any) {
        changeColor()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        changeColor()
    }
    
    func changeColor () {
        if (activeSwitch.isOn) {
            /*For on state*/
            activeSwitch.onTintColor = onColor
        } else {
            /*For off state*/
            activeSwitch.tintColor = offColor
            activeSwitch.layer.cornerRadius = 16
            activeSwitch.backgroundColor = offColor
        }
    }
    
}
