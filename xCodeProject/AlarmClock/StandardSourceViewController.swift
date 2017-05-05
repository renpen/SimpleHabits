//
//  StandardSourceViewController.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 03.05.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit

class StandardSourceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectedSoundLabel: UILabel!
    
    var sounds:[String] = SoundManager.sounds
    
    var selectedSound : AlarmSound?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        selectedSound = FileSound(fileName: "bell")
        selectedSound?.generateRepresentingCoreDataObject()
        selectedSoundLabel.text = selectedSound?.fileName
        
        
        
        self.initialChanges()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSound = FileSound(fileName: sounds[indexPath.row])
        selectedSound?.generateRepresentingCoreDataObject()
        selectedSoundLabel.text = selectedSound?.fileName
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fileSoundCell") as! FileSoundCell
        cell.soundName.text = sounds[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sounds.count
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func initialChanges() {
        backButton.layer.cornerRadius = 10
        saveButton.layer.cornerRadius = 10
    }
}
