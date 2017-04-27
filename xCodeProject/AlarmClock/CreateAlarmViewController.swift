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
    
    var userCalendars: [EKCalendar?] = []
    let calendarTools = CalendarTools.sharedInstance
    let alarmCoreDataHandler = AlarmCoreDataHandler.sharedInstance
    
    @IBAction func alarmSoundButtonPressed(_ sender: Any) {
    }
    
    @IBAction func saveAlarmPressed(_ sender: Any) {
        // Eingaben überprüfung TODO
        let alarm = alarmCoreDataHandler.fabricateAlarm()
        alarm.name = nameTF.text!
        alarm.smartAlarm = modeSwitch.isOn
        // Mode muss noch gesetzt werden ... . TODO
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
        alarm.travel?.destination = "blablaBlubber"
        alarm.calendarIdentifier = (userCalendars[calendarPicker.selectedRow(inComponent: 0)]?.calendarIdentifier)!
        alarm.save()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarPicker.dataSource = self
        calendarPicker.delegate = self
        
        calendarPicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        calendarTools.requestPermission(sender: self)
        // Do any additional setup after loading the view.
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
