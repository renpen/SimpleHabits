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
        let alarm = CoreDataHandler.sharedInstance.fabricateCoreDataObject(entityName: "Alarm") as! Alarm
        alarm.name = (parentVC.alarmObject.calendar?.title)! //just for the time until there is an implementated way to save the selected calendar in core data
        alarm.travel?.destination = "Karlsruhe"
        alarm.travel?.source = "München"
        alarm.travel?.mode = Mode.driving
        alarm.travel?.trafficModel = TrafficModel.best_guess
        alarm.offset = Int16(parentVC.alarmObject.offset)
        let currentDate = Date()
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .second, value: 10, to: currentDate)
        alarm.wakeUpTime = date!;
        AlarmController.sharedInstance.activate(alarm: alarm)
        alarm.save()
        self.dismiss(animated: true, completion: nil)
    }
}
