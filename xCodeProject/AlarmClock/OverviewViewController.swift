//
//  OverviewViewController.swift
//  AlarmClock
//
//  Created by Bene on 29/11/2016.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {

    @IBOutlet weak var offsetLabel: UILabel!
    @IBOutlet weak var calendarLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let parentVC = self.parent as! SmartTourPageViewController
        calendarLabel.text = parentVC.alarmObject.calendar?.title
        let backgroundColor = UIColor(cgColor: (parentVC.alarmObject.calendar?.cgColor)!)
        offsetLabel.text = String(parentVC.alarmObject.offset)
        calendarLabel.backgroundColor = backgroundColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func savePressed(_ sender: Any) {
        let parentVC = self.parent as! SmartTourPageViewController
        let alarm = AlarmCoreDataHandler.sharedInstance.getSmartAlarm()
        alarm.travel?.destination = "DHBW Karlsruhe"
        alarm.travel?.source = "Ludwig-Erhard-Allee 32 76131 Karlsruhe"
        alarm.travel?.mode = Mode.bicycling
        alarm.travel?.trafficModel = TrafficModel.best_guess
        alarm.offset = Int16(parentVC.alarmObject.offset)
        alarm.calendarIdentifier = (parentVC.alarmObject.calendar?.calendarIdentifier)!
        alarm.smartAlarm = true
        var fileSound = FileSound()
        fileSound.generateRepresentingCoreDataObject();
        fileSound.fileName = "bla"
        alarm.wakeUpTone = fileSound
        alarm.save()
        AlarmController.sharedInstance.activate(alarm: alarm);
        self.dismiss(animated: true, completion: nil)
    }
}
