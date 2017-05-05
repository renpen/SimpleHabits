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
    @IBOutlet weak var smartControlsView: UIView!
    @IBOutlet weak var standardControlsView: UIView!
    @IBOutlet weak var wakeTimePicker: UIDatePicker!
    
    var userCalendars: [EKCalendar?] = []
    let calendarTools = CalendarTools.sharedInstance
    let alarmCoreDataHandler = AlarmCoreDataHandler.sharedInstance
    
    var wakeUpTime:String = ""
    
    var selectedSound = FileSound()
    
    @IBAction func modeSwitched(_ sender: Any) {
        if modeSwitch.isOn {
            UIView.animate(withDuration: 0.4, animations: {
                self.smartControlsView.alpha = 1
                self.standardControlsView.alpha = 0
            })
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                self.smartControlsView.alpha = 0
                self.standardControlsView.alpha = 1
            })
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
        
        if !modeSwitch.isOn {
          alarm.wakeUpTime = wakeTimePicker.date
        }
        
        //Default value for sound if none gets selected!
        selectedSound.fileName = "bell"        
        selectedSound.generateRepresentingCoreDataObject()

        // fill wakeUpTime initially
        wakeTimePickerChanged()
        
        alarm.wakeUpTone = selectedSound
        
        switch transportationSB.selectedSegmentIndex {
        case 0:
            alarm.travel?.mode = Mode.driving
        case 1:
            alarm.travel?.mode = Mode.walking
        case 2:
            alarm.travel?.mode = Mode.bicycling
        case 3:
            alarm.travel?.mode = Mode.transit
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
        
        alarmSoundButton.layer.cornerRadius = 10
        calendarTools.requestPermission(sender: self)
        // Do any additional setup after loading the view.
        
        wakeTimePicker.addTarget(self, action: #selector(self.wakeTimePickerChanged), for: UIControlEvents.valueChanged)
        
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
    
    @IBAction func unwindToVC(segue: UIStoryboardSegue) {
        if (segue.identifier == "unwindStandardSource") {
            let vc = segue.source as! StandardSourceViewController
            selectedSound = vc.selectedSound
            print("")
        }
    }
    
    func wakeTimePickerChanged() {
        var formattedString = ""
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        formattedString = dateFormatter.string(from: wakeTimePicker.date)
        wakeUpTime = formattedString
        print(wakeUpTime)
    }
    
}
