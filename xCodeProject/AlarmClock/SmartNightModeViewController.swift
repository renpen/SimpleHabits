//
//  SmartNightModeViewController.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 15.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit

class SmartNightModeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true

    }
    @IBAction func leaveNightMode(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
