//
//  StandardSourceViewController.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 03.05.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit

class StandardSourceViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var soundPickerView: UIPickerView!
    
    var sounds:[String] = SoundManager.sounds
    
    var selectedSound:String = "bell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        soundPickerView.delegate = self
        soundPickerView.dataSource = self
        self.initialChanges()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        let soundFile = sounds[soundPickerView.selectedRow(inComponent: 0)]
        var sound = FileSound(fileName: soundFile)
        sound.generateRepresentingCoreDataObject()
        // Im createAlarmController muss jetzt nur noch alarm.alarmSound = sound: alarm.save() gemacht werden und das MOCKUP in der Methode saveAlarmPressed entfernt werden
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sounds.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sounds[row]
    }
    
    func initialChanges() {
        backButton.layer.cornerRadius = 10
        saveButton.layer.cornerRadius = 10
    }
}
