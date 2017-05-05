//
//  FileSoundCell.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 05.05.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit

class FileSoundCell: UITableViewCell {

    @IBOutlet weak var soundName: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private var sound = FileSound()
    
    @IBAction func playSoundPressed(_ sender: Any) {
        sound = FileSound(fileName: soundName.text!)
        sound.generateRepresentingCoreDataObject()
        sound.playSound()
    }
}
