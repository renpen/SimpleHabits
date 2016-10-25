//
//  ViewController.swift
//  AlarmClock
//
//  Created by ReneUser on 24.10.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pickShit: UIPickerView!
    @IBOutlet weak var pickLabel: UILabel!
    let eventStore = EKEventStore()
    @IBOutlet weak var TravelTimeLabel: UILabel!
    @IBOutlet weak var destination: UITextField!
    @IBOutlet weak var source: UITextField!
    @IBAction func calcTravel(_ sender: AnyObject) {
    let travel = Travel()
        travel.destionation = destination.text
        travel.source = source.text
        travel.calculateTime()
        while true {
            if(travel.isTravelTimeCalculated)
            {
                TravelTimeLabel.text = String(travel.travelTime!)
                break
            }
        }
    }
    let cTools = CalendarTools()
    var calendars : [EKCalendar] = []
    var events = [EKEvent]()
    override func viewDidLoad() {
        super.viewDidLoad()
        cTools.checkPermission(sender: self)
        pickShit.dataSource = self;
        pickShit.delegate = self;
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func permissionAccepted()
    {
        calendars = cTools.getAllCalendar()
        refreshPicker()
    }
    func permissionDenied()
    {
                // Show something to the User, that he needs to accept the Calendar and redicrct him to the settings where he can change the settings.
    }
    
    func refreshPicker()
    {
        pickShit.reloadAllComponents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return calendars.count
    }
    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return calendars[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let event = cTools.getNextWakeUpAppointment(calendar: calendars[row])
        var title = ""
        var time = ""
        if event == nil{
            title = "Keinen Termin"
            time = "Keinen Termin"
        }
        else
        {
            title = event!.title
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH-mm"
            time = dateFormatter.string(from: event!.startDate)
        }
        pickLabel.text = title
        timeLabel.text = time
    }

}

