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

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
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
        if mode == "smart" {
            self.switchMode(mode: "standard")
        } else if mode == "standard" {
            self.switchMode(mode: "smart")
        }
    }
    
    func updateClock () {
        let date = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let string = formatter.string(from: date)
        clockLabel.text = string
    }
    
    let eventStore = EKEventStore()
    let cTools = CalendarTools()
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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.orientationChanged), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
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
    }
    func permissionDenied()
    {
        
    }
    
    func switchMode(mode: String) {
        switch mode {
            case "smart":
                UIView.animate(withDuration: 0.4, animations: {
                    self.smartContainerView.isHidden = false
                    self.standardContainerView.isHidden = true
                    self.editButton.isHidden = true
                })
                self.activeWheatherView = self.standardWheaterImgView
                self.mode = mode
                break
            case "standard":
                UIView.animate(withDuration: 0.4, animations: {
                    self.smartContainerView.isHidden = true
                    self.standardContainerView.isHidden = false
                    self.editButton.isHidden = false
                })
                self.activeWheatherView = self.WheaterImgView
                self.mode = mode
                break
            case "landscape":
                UIView.animate(withDuration: 0.4, animations: {
                    self.smartContainerView.isHidden = true
                    self.standardContainerView.isHidden = false
                    self.editButton.isHidden = true
                })
                self.activeWheatherView = self.WheaterImgView
                self.inLandscape = true
            default:
                print("Error in switchMode()")
        }
        
    }
    
}

