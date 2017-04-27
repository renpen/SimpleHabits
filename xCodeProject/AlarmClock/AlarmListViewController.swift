//
//  AlarmListViewController.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 18.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit

class AlarmListViewController: UITableViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBAction func addAlarm(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "addAlarm")
        self.present(vc!, animated: true, completion: nil)
    }
    
    var alarms:[Alarm] = AlarmCoreDataHandler.sharedInstance.getAllAlarms()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        alarms = self.fetchAlarms()
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = self.storyboard
        let vc = sb?.instantiateViewController(withIdentifier: "alarmDetailsVC") as! AlarmDetailsViewController
        
        vc.alarmId = String(alarms[indexPath.row].id)
        vc.name = alarms[indexPath.row].name
        self.present(vc, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let alarm = alarms[indexPath.row]
        
        let cell:AlarmCell
        let smartCell:SmartAlarmCell
        
        if (alarm.smartAlarm) {
            smartCell = tableView.dequeueReusableCell(withIdentifier: "smartAlarmCell") as! SmartAlarmCell
            smartCell.alarm = alarm
            smartCell.name.text = alarm.name
            smartCell.activeSwitch.isOn = alarm.isActivated
            smartCell.changeColor()
            return smartCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell") as! AlarmCell
            cell.alarm = alarm
            cell.activeSwitch.isOn = alarm.isActivated // s.o
            cell.alarmNameLabel.text = alarm.name
            cell.wakeUpTimeLabel.text = "Platzhalter"
            cell.changeColor()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let alarm = alarms[indexPath.row]
            AlarmCoreDataHandler.sharedInstance.deleteAlarm(alarmID: alarm.id)
            alarms = self.fetchAlarms()
            tableView.reloadData()
        }
    }
    
    func fetchAlarms() -> [Alarm]{
        return AlarmCoreDataHandler.sharedInstance.getAllAlarms()
    }

}
