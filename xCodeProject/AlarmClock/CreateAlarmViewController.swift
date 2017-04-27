//
//  CreateAlarmViewController.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 27.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit
import EventKit

class CreateAlarmViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CalendarViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var modeSwitch: UISwitch!
    @IBOutlet weak var transportationSB: UISegmentedControl!
    @IBOutlet weak var calendarPicker: UIPickerView!
    @IBOutlet weak var alarmSoundButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var wakeupTimeButton: UIButton!
    
    @IBAction func wakeupTimePressed(_ sender: Any) {
        
    }
    
    var userCalendars: [EKCalendar?] = []
    let calendarTools = CalendarTools.sharedInstance
    let alarmCoreDataHandler = AlarmCoreDataHandler.sharedInstance
    
    @IBAction func modeSwitched(_ sender: Any) {
        if modeSwitch.isOn {
            wakeupTimeButton.isEnabled = false
            wakeupTimeButton.alpha = 0.5
        } else {
            wakeupTimeButton.isEnabled = true
            wakeupTimeButton.alpha = 1
        }
    }
    
    @IBAction func alarmSoundButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAlarmPressed(_ sender: Any) {
        // Eingaben überprüfung TODO
        let alarm = alarmCoreDataHandler.fabricateAlarm()
        alarm.name = nameTF.text!
        alarm.smartAlarm = modeSwitch.isOn
        // Mode muss noch gesetzt werden ... . TODO
        // -> modeSwitch.isOn here ;)
        
        switch transportationSB.selectedSegmentIndex {
        case 1:
            alarm.travel?.mode = Mode.bicycling
        case 2:
            alarm.travel?.mode = Mode.driving
            //TODO
//        case 3:
//        case 4:
//        case 5:
        default:
            alarm.travel?.mode = Mode.driving
        }
        alarm.calendarIdentifier = (userCalendars[calendarPicker.selectedRow(inComponent: 0)]?.calendarIdentifier)!
        alarm.save()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarPicker.dataSource = self
        calendarPicker.delegate = self
        
        calendarPicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        saveButton.layer.cornerRadius = 10
        alarmSoundButton.layer.cornerRadius = 10
        wakeupTimeButton.layer.cornerRadius = 10
        
        calendarTools.requestPermission(sender: self)
        // Do any additional setup after loading the view.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func permissionGiven() {
        userCalendars = calendarTools.getAllCalendar()
        calendarPicker.reloadAllComponents()
    }
    func permissionDeied() {
        //TODO
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
