//
//  SmartAlarmCell.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 27.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit

class SmartAlarmCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var activeSwitch: UISwitch!
    
    var onColor = UIColor(red:1.00, green:0.53, blue:0.04, alpha:1.0)
    var offColor = UIColor(red:0.67, green:0.67, blue:0.67, alpha:1.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func switchChanged(_ sender: Any) {
        changeColor()
        //change the isActive status here!
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
