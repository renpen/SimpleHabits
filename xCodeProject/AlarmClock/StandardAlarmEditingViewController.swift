//
//  AlarmEditingViewController.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 05.05.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit

class StandardAlarmEditingViewController: UIViewController {
    
    var alarm:Alarm!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var wakeTimePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = alarm.name
        // Just getting the alarm.wakeUpTime for the picker is not correct because the date of the alarm could be in the future or in the past and with the picker you only change hours and minutes -> the alarm will not ring because the date is in the past. 
        let hour = Calendar.current.component(.hour, from: alarm.wakeUpTime!)
        let minute = Calendar.current.component(.minute, from: alarm.wakeUpTime!)
        let calendar = Calendar.current
        let now = Date()
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
        components.hour = hour
        components.minute = minute
        components.second = 0
        let pickerdate = calendar.date(from: components)!
        wakeTimePicker.date = pickerdate
    }
    
    @IBAction func savePressed(_ sender: Any) {
        alarm.name = textField.text!
        alarm.wakeUpTime = wakeTimePicker.date
        alarm.save()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
