//
//  AlarmListViewController.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 18.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit

class tmpAlarm: NSObject {
    var wakeUpTime:Date = Date()
    var active:Bool = true
    var name:String = ""
    var isSmart:Bool = true
    var id = "1"
}

class AlarmListViewController: UITableViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var alarms:[tmpAlarm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        var tmp = tmpAlarm()
        tmp.wakeUpTime = Date()
        tmp.name = "My Alarm"
        tmp.isSmart = false
        tmp.active = false
        alarms.append(tmp)
        
        tmp = tmpAlarm()
        tmp.wakeUpTime = Date()
        tmp.name = "Aufstehen"
        alarms.append(tmp)
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
        
        vc.alarmId = alarms[indexPath.row].id
        vc.name = alarms[indexPath.row].name
        
        self.present(vc, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell") as! AlarmCell
        
        cell.activeSwitch.isOn = alarms[indexPath.row].active // s.o
        
        cell.alarmNameLabel.text = alarms[indexPath.row].name
        let wakeUpTime = alarms[indexPath.row].wakeUpTime
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        cell.wakeUpTimeLabel.text = formatter.string(from: wakeUpTime)
        
        if (alarms[indexPath.row].isSmart) {
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
