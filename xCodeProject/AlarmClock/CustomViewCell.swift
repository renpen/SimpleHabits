//
//  CustomViewCell.swift
//  AlarmClock
//
//  Created by René Penkert on 27.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import Foundation

public class CustomViewCell : UITableViewCell
{
    var onColor = UIColor(red:1.00, green:0.53, blue:0.04, alpha:1.0)
    var offColor = UIColor(red:0.67, green:0.67, blue:0.67, alpha:1.0)
    var alarm : Alarm?
    
    @IBOutlet weak var activeSwitch: UISwitch!
    
    @IBAction func switchChanged(_ sender: Any) {
        changeColor()
        //change the isActive status here!
    }
    
    func changeColor () {
        if (activeSwitch.isOn) {
            activeSwitch.onTintColor = onColor
        } else {
            /*For off state*/
            activeSwitch.tintColor = offColor
            activeSwitch.layer.cornerRadius = 16
            activeSwitch.backgroundColor = offColor
        }
        alarm?.isActivated = activeSwitch.isOn
        alarm?.save()
    }

}
