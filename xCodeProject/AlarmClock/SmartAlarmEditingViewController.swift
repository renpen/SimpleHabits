//
//  SmartAlarmViewController.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 05.05.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit
import EventKit

class SmartAlarmEditingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CalendarViewController {

    var alarm:Alarm!
    
    var calendars: [EKCalendar?] = []
    
    let calendarTools = CalendarTools.sharedInstance
    
    @IBOutlet weak var labelName: UITextField!
    @IBOutlet weak var transportationSegmented: UISegmentedControl!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidAppear(_ animated: Bool) {
        calendarTools.requestPermission(sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        labelName.text = alarm.name
        self.setTransportationSegmented()
    }
    
    func setTransportationSegmented() {
        
        // NOTE: BAD STYLE Implementation!
        
        //just to get it work for now.. switch case enum -> swift / Xcode pain!
        
        let x = alarm.travel?.mode?.rawValue
        if x == "driving" {
            transportationSegmented.selectedSegmentIndex = 0
        } else if x == "walking" {
            transportationSegmented.selectedSegmentIndex = 1
        } else if x == "bycycling" {
            transportationSegmented.selectedSegmentIndex = 2
        } else if x == "transit" {
            transportationSegmented.selectedSegmentIndex = 3
        }
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getRowOfCurrentCalendarInPickerView() -> Int {
        
        var i = 0
        for c in calendars {
            if c?.calendarIdentifier == alarm.calendarIdentifier {
                return i
            }
            i += 1
        }
        return 404
    }
    
    @IBAction func savePressed(_ sender: Any) {
        switch transportationSegmented.selectedSegmentIndex {
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
        
        alarm.calendarIdentifier = (calendars[pickerView.selectedRow(inComponent: 0)]?.calendarIdentifier)!
        alarm.name = labelName.text!
        alarm.save()
        self.dismiss(animated: true, completion: nil)
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return calendars[row]?.title
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return calendars.count
    }
    
    func permissionGiven() {
        calendars = calendarTools.getAllCalendar()
        pickerView.reloadAllComponents()
        let calendarIndex = getRowOfCurrentCalendarInPickerView()
        pickerView.selectRow(calendarIndex, inComponent: 0, animated: true)
    }
    func permissionDeied() {
        //TODO
    }
    
}
