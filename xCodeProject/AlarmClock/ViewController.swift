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
        //transition.startingPoint = smartButton.center
        transition.circleColor = UIColor.black
        
        return transition
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        //transition.startingPoint = smartButton.center
        transition.circleColor = UIColor(red: 255/255, green: 147/255, blue: 59/255, alpha: 1.0)
        
        return transition
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "SmartTourInitialize") {
            let destionationVC = segue.destination as!SmartTourPageViewController
            destionationVC.transitioningDelegate = self
            destionationVC.modalPresentationStyle = .custom
        }
    }
    
    var timer: Timer?

    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var WheaterImgView: UIImageView!
    @IBOutlet weak var transportationImgView: UIImageView!
    @IBOutlet weak var smartContainerView: UIView!
    @IBOutlet weak var standardWheaterImgView: UIImageView!
    @IBOutlet weak var standardContainerView: UIView!
    @IBOutlet weak var alarmIcon: UILabel!
    @IBOutlet weak var alarmLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var clockLabel: UILabel!
    
    var smartMode = true;
    var format = DateFormatter()
    var activeWheatherView = UIImageView()
    
    @IBAction func settingsPressed(_ sender: Any) {
        if (settingsView.alpha == 0) {
            settingsButton.setTitle("\u{f00d}", for: .normal)
            UIView.animate(withDuration: 0.5, animations: {
                self.settingsView.alpha = 0.75
            })
        } else {
            settingsButton.setTitle("\u{f013}", for: .normal)
            UIView.animate(withDuration: 0.5, animations: {
                self.settingsView.alpha = 0
            })
        }
    }
    
    @IBAction func switchClicked(_ sender: Any) {
        //temporary
        if (smartMode){
            smartContainerView.isHidden = true
            standardContainerView.isHidden = false
            editButton.isHidden = false
            activeWheatherView = WheaterImgView
        } else {
            smartContainerView.isHidden = false
            standardContainerView.isHidden = true
            editButton.isHidden = true
            activeWheatherView = standardWheaterImgView
        }
        smartMode = !smartMode
    }
    
    func updateClock () {
        let date = Date()
        
        var formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        var string = formatter.string(from: date)
        print(string)
        
        clockLabel.text = string
    }
    
    let eventStore = EKEventStore()
    let cTools = CalendarTools()
    var calendars : [EKCalendar] = []
    var events = [EKEvent]()
    
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    func orientationChanged() {
        if(UIDeviceOrientationIsLandscape(UIDevice.current.orientation)){
            backgroundImageView.image = UIImage(named:"landscapeBackground.jpg")
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.current.orientation)){
            backgroundImageView.image = UIImage(named:"portaitBackground.jpg")
        }
    }
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: Selector("orientationChanged"), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        updateClock()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in

            self?.updateClock()
            
        }
        
        editButton.setTitle("\u{f044}", for: .normal)
        settingsButton.backgroundColor = .clear
        settingsButton.layer.cornerRadius = 5
        settingsButton.layer.borderWidth = 1.5
        settingsButton.layer.borderColor = UIColor.white.cgColor
        settingsButton.setTitle("\u{f013}", for: .normal)
        
        alarmIcon.text = "\u{f0f3}"
        settingsButton.layer.cornerRadius = 0.5 * settingsButton.bounds.size.width
        
        settingsView.layer.cornerRadius = 20
        settingsView.clipsToBounds = true
        
        cTools.requestPermission(sender: self)
        let test = FunctionTest()           //for test purpose funciomalites
        test.testSomething()
        
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
        //pickLabel.text = title
        //timeLabel.text = time
    }
    
    

}

