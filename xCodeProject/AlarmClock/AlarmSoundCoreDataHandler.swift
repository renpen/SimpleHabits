//
//  AlarmSoundCoreDataHandler.swift
//  AlarmClock
//
//  Created by René Penkert on 11.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import Foundation
import CoreData

class AlarmSoundCoreDataHandler : CoreDataHandler
{
    static let sharedInstance = AlarmSoundCoreDataHandler()
    
    private func getNewAlarmSoundID () ->Int32
    {
        let entityDescription = getEntityDescirption(entityName: "AlarmSoundC")
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entityDescription
        request.fetchLimit = 1;
        request.sortDescriptors = [NSSortDescriptor.init(key: "id", ascending: false)]
        var objects : Array<Any>? = nil
        do{
            try objects = managedObjectContext.fetch(request)
        }
        catch
        {
            
        }
        if objects?.count != 0
        {
            return (objects![0] as! AlarmSoundC).id + 1
        }
        return 0
    }
    internal func fabricateAlarmSoundCObject() -> AlarmSoundC {
        let alarmSoundC:AlarmSoundC = fabricateCoreDataObject(entityName: "AlarmSoundC") as! AlarmSoundC
            alarmSoundC.id = getNewAlarmSoundID()
            return alarmSoundC
    }
    
    internal func getAlarmSoundById(id: Int32) -> AlarmSound? {
        let pred = NSPredicate(format: "(id = %@)", String(id))
        let objects = getObjects(entityName: "AlarmSoundC", predicate: pred)
        if let objects = objects {
            let alarmSoundC = objects[0] as? AlarmSoundC
            var alarmSound : AlarmSound?
            switch alarmSoundC?.source {
            case SoundTypes.appleMusic.rawValue?:
                print("AppleMusic")
            case SoundTypes.file.rawValue? :
                alarmSound = FileSound()
            case SoundTypes.spotify.rawValue? :
                print("Spotify")
            default:
                print("default")
                //TODO
            }
            alarmSound?.setRepresentingCoreDataValues(coreDataAlarmSound: alarmSoundC!)
            return alarmSound
        }
        return nil
        
    }



}
