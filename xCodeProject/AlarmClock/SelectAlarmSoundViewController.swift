//
//  SelectAlarmSoundViewController.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 03.05.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit

class SelectAlarmSoundViewController: UIViewController {

    @IBOutlet weak var standardButton: UIButton!
    @IBOutlet weak var appleMusicButton: UIButton!
    @IBOutlet weak var spotifyButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initialChanges()
    }
    
    func initialChanges() {
        standardButton.layer.cornerRadius = 10
        appleMusicButton.layer.cornerRadius = 10
        spotifyButton.layer.cornerRadius = 10
        backButton.layer.cornerRadius = 10
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
