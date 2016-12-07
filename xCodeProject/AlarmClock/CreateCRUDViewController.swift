//
//  CreateCRUDViewController.swift
//  AlarmClock
//
//  Created by Bene on 17/11/2016.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import UIKit

class CreateCRUDViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var offsetTF: UITextField!
    
    @IBOutlet weak var sourceTF: UITextField!
    
    @IBOutlet weak var DestinationTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func save(_ sender: Any) {
        
        
        let alarm = CoreDataHandler.sharedInstance.fabricateCoreDataObject(entityName: "Alarm") as! Alarm
        alarm.name = nameTF.text!
        alarm.travel?.destination = DestinationTF.text!
        alarm.travel?.source = sourceTF.text!
        alarm.offset = Int16(offsetTF.text!)!
        alarm.travel?.mode = Mode.driving
        alarm.travel?.trafficModel = TrafficModel.best_guess
        alarm.save()
        
        self.dismiss(animated: true, completion: nil)
    }
}
