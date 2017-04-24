//
//  AlarmDetailsViewController.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 24.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit

class AlarmDetailsViewController: UIViewController {

    var alarmId:String!
    var name:String!
    
    @IBOutlet weak var alarmName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alarmName.text = name
        // Do any additional setup after loading the view.
    }
    
    @IBAction func leaveView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
