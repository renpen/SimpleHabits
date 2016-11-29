//
//  CalendarSelectionViewController.swift
//  AlarmClock
//
//  Created by Bene on 29/11/2016.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import UIKit
import EventKit

class CalendarSelectionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var displayCalendarNameLabel: UILabel!
    
    var calendarsNames = [String]()
    var calendars: [EKCalendar] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.picker.dataSource = self
        self.picker.delegate = self
        
        let calendarHelper = CalendarTools()
        calendars = calendarHelper.getAllCalendar()
        
        for i in 0...(calendars.count-1) {
            calendarsNames.append(calendars[i].title)
        }
        
        let backgroundColor = UIColor(cgColor: calendars[0].cgColor)
        
        displayCalendarNameLabel.text = calendarsNames[0]
        displayCalendarNameLabel.backgroundColor = backgroundColor
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return calendarsNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return calendarsNames[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        displayCalendarNameLabel.text = calendarsNames[row]
        let backgroundColor = UIColor(cgColor: calendars[row].cgColor)
        displayCalendarNameLabel.backgroundColor = backgroundColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let parentVC = self.parent as! SmartTourPageViewController
        parentVC.alarmObject.calendar = calendarsNames[picker.selectedRow(inComponent: 0)]
        let backgroundColor = UIColor(cgColor: calendars[picker.selectedRow(inComponent: 0)].cgColor)
        parentVC.alarmObject.calendarColor = backgroundColor
    }
}
