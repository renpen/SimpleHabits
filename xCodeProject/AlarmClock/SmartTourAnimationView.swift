//
//  SmartTourAnimationView.swift
//  AlarmClock
//
//  Created by Bene on 08.11.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import UIKit

class SmartTourAnimationView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "SmartCreationTour") {
            self.present(pageViewController, animated: false, completion: nil)
        }
    }

}
