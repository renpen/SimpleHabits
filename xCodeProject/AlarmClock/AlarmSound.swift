//
//  AlarmSound.swift
//  AlarmClock
//
//  Created by René Penkert on 11.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import Foundation
import CoreData

protocol AlarmSound {
    var fileName : String? {get set}
    var url : String? {get set}
    var source : String? {get set}
    var representingCoreDataObject : AlarmSoundC? {get set}
    func playSound();
}
extension AlarmSound {
    mutating func save()
    {
        representingCoreDataObject?.fileName = fileName
        representingCoreDataObject?.url = url;
        representingCoreDataObject?.source = source
        AlarmSoundCoreDataHandler.sharedInstance.save()
    }
    mutating func setRepresentingCoreDataValues(coreDataAlarmSound : AlarmSoundC)
    {
        fileName = coreDataAlarmSound.fileName
        url = coreDataAlarmSound.url
        source = coreDataAlarmSound.source
        representingCoreDataObject = coreDataAlarmSound
    }
    mutating func generateRepresentingCoreDataObject()
    {
        representingCoreDataObject = AlarmSoundCoreDataHandler.sharedInstance.fabricateAlarmSoundCObject();
        save()
    }
    
}
