//
//  menuContentViewController.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 18.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit

class menuContentViewController: UITableViewController {

    @IBOutlet weak var AlarmsLogo: UILabel!
    @IBOutlet weak var settingsLogo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .none
        self.tableView.alwaysBounceVertical = false
        
        AlarmsLogo.text = "\u{f017}"
        settingsLogo.text = "\u{f1de}"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
