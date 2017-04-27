//
//  CreateAlarmViewController.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 27.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit
import EventKit

class CreateAlarmViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var modeSwitch: UISwitch!
    @IBOutlet weak var transportationSB: UISegmentedControl!
    @IBOutlet weak var calendarPicker: UIPickerView!
    @IBOutlet weak var alarmSoundButton: UIButton!
    
    var userCalendars: [EKCalendar?] = []
    
    @IBAction func alarmSoundButtonPressed(_ sender: Any) {
    }
    
    @IBAction func saveAlarmPressed(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarPicker.dataSource = self
        calendarPicker.delegate = self
        
        calendarPicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        userCalendars = self.fetchCalendars()
        calendarPicker.reloadAllComponents()
        // Do any additional setup after loading the view.
    }
    
    func fetchCalendars() -> [EKCalendar]{
        //let si = CalendarTools.sharedInstance
        
        return []
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userCalendars[row]?.title
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userCalendars.count
    }
    
}
