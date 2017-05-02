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
    @IBOutlet weak var wakeTimeLabel: UILabel!
    
    var userCalendars: [EKCalendar?] = []
    let calendarTools = CalendarTools.sharedInstance
    let alarmCoreDataHandler = AlarmCoreDataHandler.sharedInstance
    
    @IBAction func modeSwitched(_ sender: Any) {
        if modeSwitch.isOn {
            wakeupTimeButton.isEnabled = false
            wakeupTimeButton.alpha = 0.5
            calendarPicker.isHidden = false
            transportationSB.isHidden = false
        } else {
            wakeupTimeButton.isEnabled = true
            wakeupTimeButton.alpha = 1
            calendarPicker.isHidden = true
            transportationSB.isHidden = true
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
        
        //THIS IS ONLY FOR MOCKUP NEED TO BE REPLACED WITH THE CORRECT ALARMSOUND ON THE UI
        var sound = FileSound()
        sound.generateRepresentingCoreDataObject()
        sound.fileName = "bell"
        alarm.wakeUpTone = sound
        
        
        // Mode muss noch gesetzt werden ... . TODO
        // -> modeSwitch.isOn here ;)
        switch transportationSB.selectedSegmentIndex {
        case 1:
            alarm.travel?.mode = Mode.driving
        case 2:
            alarm.travel?.mode = Mode.walking
        case 3:
            alarm.travel?.mode = Mode.bicycling
        case 4:
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
        
        calendarPicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        saveButton.layer.cornerRadius = 10
        alarmSoundButton.layer.cornerRadius = 10
        wakeupTimeButton.layer.cornerRadius = 10
        self.wakeTimeViewInitialChanges()
        
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
    
    // Control for hidden WakeTime View!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var wakeTimeContentView: UIView!
    @IBOutlet weak var closeWakeTime: UIButton!
    @IBOutlet weak var wakeTimePicker: UIDatePicker!
    @IBOutlet weak var setWakeTimeLabel: UILabel!
    
    @IBAction func wakeupTimePressed(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.blurView.alpha = 1.0
        })
    }
    
    @IBAction func closePressed(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.blurView.alpha = 0
            self.wakeTimeLabel.text = self.setWakeTimeLabel.text
        })
    }
    
    func wakeTimeViewEntered() {
        self.wakeTimePickerChanged()
    }
    
    func wakeTimeViewInitialChanges() {
        wakeTimePicker.addTarget(self, action: #selector(self.wakeTimePickerChanged), for: UIControlEvents.valueChanged)
        wakeTimeContentView.layer.cornerRadius = 15
    }
    
    func wakeTimePickerChanged() {
        var formattedString = ""
        var dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        formattedString = dateFormatter.string(from: wakeTimePicker.date)
        setWakeTimeLabel.text = formattedString
    }
    
}
