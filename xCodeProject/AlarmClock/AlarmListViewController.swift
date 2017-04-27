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
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //fetch core data here!
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell") as! AlarmCell
        
        cell.activeSwitch.isOn = alarm.isActivated // s.o
        
        cell.alarmNameLabel.text = alarm.name
        let wakeUpTime = alarm.wakeUpTime
        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "HH:mm"
        cell.wakeUpTimeLabel.text = "Platzhalter"
        if (alarm.smartAlarm) {
            cell.smartImage.backgroundColor = .white
        } else {
            cell.smartImage.backgroundColor = .red
        }
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
