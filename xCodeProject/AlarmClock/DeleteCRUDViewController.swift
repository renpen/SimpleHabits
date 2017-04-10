//
//  DeleteCRUDViewController.swift
//  AlarmClock
//
//  Created by Bene on 17/11/2016.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import UIKit

class DeleteCRUDViewController: UIViewController {

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
    
    @IBOutlet weak var nameTF: UITextField!
    
    
//    @IBAction func deletePressed(_ sender: Any) {
//        CoreDataHandler.sharedInstance.deleteObject(entity: nameTF.text!)
//    }
    
}
