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

class ViewController: UIViewController, UIViewControllerTransitioningDelegate, CalendarViewController {
    
    var timer: Timer?
    
    var popoverAlpha = 0.75
    var animationDuration = 0.5

    @IBOutlet weak var alarmPicker: UIDatePicker!
    
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

    @IBOutlet weak var alarmPickerView: UIView!
    
    var activeWheatherView = UIImageView()
    var settingsCD =  SettingsCoreDataHandler.sharedInstance.getSettings()
    var alarmCDHandler = AlarmCoreDataHandler.sharedInstance
    
    @IBAction func settingsPressed(_ sender: Any) {
        if (settingsView.alpha == 0) {
            settingsButton.setTitle("\u{f00d}", for: .normal)
            UIView.animate(withDuration: animationDuration, animations: {
                self.settingsView.alpha = CGFloat(self.popoverAlpha)
            })
        } else {
            settingsButton.setTitle("\u{f013}", for: .normal)
            UIView.animate(withDuration: animationDuration, animations: {
                self.settingsView.alpha = 0
            })
        }
    }
    
    @IBAction func editAlarmPressed(_ sender: Any) {
        if alarmPickerView.alpha == 0 {
            UIView.animate(withDuration: animationDuration, animations: {
                self.alarmPickerView.alpha = CGFloat(self.popoverAlpha)
            })
            editButton.setTitle("\u{f0c7}", for: .normal)
        } else {
            closeAlarmEditing()
        }
    }
    
    func closeAlarmEditing () {
        UIView.animate(withDuration: animationDuration, animations: {
            self.alarmPickerView.alpha = 0
        })
        editButton.setTitle("\u{f044}", for: .normal)
        let alarmDate = alarmPicker.date
        writeStandardAlarmTime(editedTime: alarmDate)
        setAlarmLabel(alarmDate: alarmDate)
       // standardAlarmSavedAfterEditing(newAlarmString: string, newAlarmDate: alarmPicker.date)
    }
    
    func setAlarmLabel(alarmDate : Date?)
    {
        if let alarmDate = alarmDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let string = formatter.string(from: alarmDate)
            alarmLabel.text = string
        }
        
    }
    
    func writeStandardAlarmTime(editedTime : Date)
    {
        let currentDate = Date()
        var editedTime = editedTime
        //when the currentTime bigger is than the edited time it implies that the alarm is for the next day, so it need to be added one day
        if editedTime < currentDate
        {
            var dateComponents = DateComponents()
            dateComponents.day = 1
            let userCalendar = Calendar.current
            editedTime = userCalendar.date(byAdding: dateComponents, to: editedTime, wrappingComponents: true)!
        }
        let standardAlarm = alarmCDHandler.fabricateAlarm()
        standardAlarm.wakeUpTime = editedTime
        if standardAlarm.wakeUpTone == nil{
            writeAlarmSound(alarm: standardAlarm)
        }
        standardAlarm.activate()
        standardAlarm.save()
    }
    
    func writeAlarmSound(alarm : Alarm)
    {
        var fileSound = FileSound()
        fileSound.generateRepresentingCoreDataObject()
        fileSound.fileName = "bell"
        fileSound.save()
        alarm.wakeUpTone = fileSound
        alarm.save()
    }
    func standardAlarmSavedAfterEditing (newAlarmString: String, newAlarmDate: Date) {
        
        
    }
    
    @IBAction func switchClicked(_ sender: Any) {
        if mode == "smart" {
            self.switchMode(mode: "standard")
            
        } else if mode == "standard" {
            self.switchMode(mode: "smart")
        }
    }

    let eventStore = EKEventStore()
    let cTools = CalendarTools.sharedInstance
    let lTools = LocationTools.sharedInstance
    var calendars : [EKCalendar] = []
    var events = [EKEvent]()
    
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var logoButton: UIButton!
    
    var mode = "smart"
    var inLandscape = true
    
    func orientationChanged() {
        if(UIDeviceOrientationIsLandscape(UIDevice.current.orientation)){
            backgroundImageView.image = UIImage(named:"landscapeBackground.jpg")
            self.switchMode(mode: "landscape")
            logoButton.isHidden = true
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.current.orientation)){
            logoButton.isHidden = false
            backgroundImageView.image = UIImage(named:"portaitBackground.jpg")
            self.switchMode(mode: self.mode)
        }
    }
    
    func preloadUIChanges() {
        editButton.setTitle("\u{f044}", for: .normal)
        
        settingsButton.backgroundColor = .clear
        settingsButton.layer.cornerRadius = 5
        settingsButton.layer.borderWidth = 1.5
        settingsButton.layer.borderColor = UIColor.white.cgColor
        settingsButton.setTitle("\u{f013}", for: .normal)
        settingsButton.layer.cornerRadius = 0.5 * settingsButton.bounds.size.width
        
        alarmIcon.text = "\u{f0f3}"
        
        alarmPickerView.layer.cornerRadius = 15
        
        settingsView.layer.cornerRadius = 20
        settingsView.clipsToBounds = true
    }
    
    func setClock () {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.orientationChanged), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        updateClock()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateClock()
            
        }
    }
    
    func updateClock() {
        let date = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let string = formatter.string(from: date)
        clockLabel.text = string
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if settingsCD.isStatusSmart
        {
            switchMode(mode: "smart")
        }
        else
        {
            switchMode(mode: "standard")
            //alarmCDHandler.
            
        }
        setClock()
        preloadUIChanges()
        cTools.requestPermission(sender: self)
        lTools.startLocating()
        WeatherAPIHandler.sharedInstance.getWeatherForCurrentPosition(closure: doSomethingWithWeather)
//        let test = FunctionTest()           //for test purpose funciomalites
//        test.testSomething()
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
     func permissionGiven() {
        calendars = cTools.getAllCalendar()
    }

     func permissionDeied() {
        //TODO
    }
    
    func switchMode(mode: String) {
        switch mode {
            case "smart":
                hideSettingsForLandscape(input: false)
                
                self.smartContainerView.isHidden = false
                self.standardContainerView.isHidden = true
                self.editButton.isHidden = true
                self.activeWheatherView = self.standardWheaterImgView
                self.settingsCD.isStatusSmart = true
                self.settingsCD.save()
                self.mode = mode
                break
            case "standard":
                hideSettingsForLandscape(input: false)
                
                self.smartContainerView.isHidden = true
                self.standardContainerView.isHidden = false
                self.editButton.isHidden = false
                self.activeWheatherView = self.WheaterImgView
                self.settingsCD.isStatusSmart = false
                self.settingsCD.save()
//                setAlarmLabel(alarmDate: alarmCDHandler.getStandardAlarm().wakeUpTime)
//                alarmCDHandler.getStandardAlarm().activate()
                self.mode = mode
                break
            case "landscape":
                hideSettingsForLandscape(input: true)
                
                self.smartContainerView.isHidden = true
                self.standardContainerView.isHidden = false
                self.editButton.isHidden = true
                self.activeWheatherView = self.WheaterImgView
                self.inLandscape = true
            default:
                print("Error in switchMode()")
        }
        
    }
    
    func hideSettingsForLandscape (input: Bool) {
        settingsButton.isHidden = input
        settingsView.isHidden = input

    }
    
    func doSomethingWithWeather(weather : Weather)
    {
        print(weather.icon);
    }
    
}

