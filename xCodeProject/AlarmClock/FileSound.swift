//
//  FileSound.swift
//  AlarmClock
//
//  Created by René Penkert on 11.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import Foundation


class FileSound : AlarmSound
{
    var fileName : String?
    var url : String?
    var source : String?
    var representingCoreDataObject : AlarmSoundC?
    
    init(fileName : String) {
         self.fileName = fileName
        source = SoundTypes.file.rawValue
    }
    init() {
        source = SoundTypes.file.rawValue
    }
    func playSound() {
        SoundPlayer.sharedInstance.playSound(fileName: self.fileName!)
    }
    
}
