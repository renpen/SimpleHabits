//
//  ShowCRUDViewController.swift
//  AlarmClock
//
//  Created by Bene on 17/11/2016.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import UIKit

class ShowCRUDViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var alarms = [Alarm]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    func loadAlarms() {
        alarms = CoreDataHandler.sharedInstance.getAllAlarms() 
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadAlarms()
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarms") as! ShowTableViewCell
        
        cell.alarmName!.text = alarms[indexPath.row].name
        cell.alarmSource!.text = alarms[indexPath.row].travel?.source
        cell.alarmDestination!.text = alarms[indexPath.row].travel?.destination
        
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            CoreDataHandler.sharedInstance.deleteAlarn(alarmName: alarms[indexPath.row].name)
            loadAlarms()
            tableView.reloadData()
        }
        
    }

}
