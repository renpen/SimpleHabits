//
//  ViewController.swift
//  AlarmClock
//
//  Created by ReneUser on 24.10.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import UIKit
import EventKit
import CoreData

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate, UIViewControllerTransitioningDelegate {
    
    let transition = CircularTransition()
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = smartButton.center
        transition.circleColor = UIColor.black
        
        return transition
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = smartButton.center
        transition.circleColor = UIColor(red: 255/255, green: 147/255, blue: 59/255, alpha: 1.0)
        
        return transition
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destionationVC = segue.destination as!SmartTourPageViewController
        destionationVC.transitioningDelegate = self
        destionationVC.modalPresentationStyle = .custom
    }
    
    
    @IBOutlet weak var smartButton: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pickShit: UIPickerView!
    @IBOutlet weak var pickLabel: UILabel!
    @IBOutlet weak var TravelTimeLabel: UILabel!
    @IBOutlet weak var destination: UITextField!
    @IBOutlet weak var source: UITextField!
    @IBAction func calcTravel(_ sender: AnyObject) {
    var travel = InternalHelper.sharedInstance.getTravel()
        travel.destination = destination.text
        travel.source = source.text
        travel.mode = Mode.walking
        travel.calculateTravelTime(closure: {x in self.TravelTimeLabel.text? = x;print("closure arrived: \(x)")})
    }
    
    let eventStore = EKEventStore()
    let cTools = CalendarTools()
    var calendars : [EKCalendar] = []
    var events = [EKEvent]()
    override func viewDidLoad() {
        super.viewDidLoad()
        cTools.checkPermission(sender: self)
        let test = FunctionTest()           //for test purpose funciomalites
        test.testSomething()
        /*
         
         UI Picker for Calendars is removed!
         
        */
        //pickShit.dataSource = self;
        //pickShit.delegate = self;
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
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
        //pickShit.reloadAllComponents()
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
        let event = cTools.getFirstAppointmentOneDayLater(calendar: calendars[row])
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

