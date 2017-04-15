//
//  SmartTabViewController.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 15.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit

class SmartTabViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
