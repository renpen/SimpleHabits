//
//  OffsetSelectionViewController.swift
//  AlarmClock
//
//  Created by Bene on 29/11/2016.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import UIKit

class OffsetSelectionViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let parentVC = self.parent as! SmartTourPageViewController
        parentVC.alarmObject.offset = Int(inputField.text!)!
    }
}
