//
//  HomeScreenViewController.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 18.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var alarmLabel: Clock!
    
    var timer: Timer?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        if revealViewController() != nil {
            
            menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.orientationChanged), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)

        // Do any additional setup after loading the view.
        setAlarmAndLabel()
    }
    
    func setAlarmAndLabel () {
        alarmLabel.text = "6:45"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("home entered")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func orientationChanged () {
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
