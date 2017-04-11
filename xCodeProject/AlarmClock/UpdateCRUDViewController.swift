//
//  UpdateCRUDViewController.swift
//  AlarmClock
//
//  Created by Bene on 17/11/2016.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import UIKit

class UpdateCRUDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var destinationTF: UITextField!
    
    @IBAction func updatePressed(_ sender: Any) {
//        let updateAlarm = CoreDataHandler.sharedInstance.getAlarmByName(name: nameTF.text!)
//        
//        updateAlarm?.travel?.destination = destinationTF.text!
//        
//        updateAlarm?.save()
//        
//        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
