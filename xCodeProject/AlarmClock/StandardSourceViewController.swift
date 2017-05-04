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
    
    var selectedSound:FileSound = FileSound()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        soundPickerView.delegate = self
        soundPickerView.dataSource = self
        
        let soundFile = sounds[soundPickerView.selectedRow(inComponent: 0)]
        selectedSound = FileSound(fileName: soundFile)
        selectedSound.generateRepresentingCoreDataObject()
        
        self.initialChanges()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let soundFile = sounds[soundPickerView.selectedRow(inComponent: 0)]
        selectedSound = FileSound(fileName: soundFile)
        selectedSound.generateRepresentingCoreDataObject()
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
