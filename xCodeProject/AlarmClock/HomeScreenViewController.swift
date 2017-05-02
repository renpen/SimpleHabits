//
//  HomeScreenViewController.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 18.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var alarmLabel: Clock!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    var timer: Timer?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        if revealViewController() != nil {
            
            menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.orientationChanged), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)

        // Do any additional setup after loading the view.
        LocationTools.sharedInstance.startLocating()
        setAlarmAndLabel()
        activateAllAlarms()
        CurrentWeather.sharedInstance.startRequesting(closure: setWeather)
    }
    
    func activateAllAlarms()
    {
        let alarms = AlarmCoreDataHandler.sharedInstance.getAllAlarms()
        for alarm in alarms {
            if alarm.isActivated {
                alarm.activate()
            }
        }
    }
    func setAlarmAndLabel () {
        let date = getNextAciveAlarmDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        var alarmLabelText = "---"
        if date != nil {
            alarmLabelText = formatter.string(from: date!)
        }
        alarmLabel.text = alarmLabelText
        
    }
    private func getNextAciveAlarmDate() -> Date?
    {
        let alarms = AlarmCoreDataHandler.sharedInstance.getAllAlarms()
        var nextDate : Date?
        for alarm in alarms {
            if alarm.wakeUpTime != nil  {
            alarm.validateWakeUpTime()
            if alarm.isActivated {
                if nextDate == nil
                {
                    nextDate = alarm.wakeUpTime!
                }
                else if nextDate! > alarm.wakeUpTime!
                {
                    nextDate = alarm.wakeUpTime!
                }
            }
        }
    }
           return nextDate
    }
    override func viewWillAppear(_ animated: Bool) {
        print("home entered")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func orientationChanged () {
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setWeather(weather : Weather)
    {
        self.weatherImageView.image = UIImage(named: weather.icon)
        self.weatherLabel.text = "\(weather.temp) C"
    }
}
