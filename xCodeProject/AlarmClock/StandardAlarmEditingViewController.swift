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
        wakeTimePicker.date = alarm.wakeUpTime!
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
