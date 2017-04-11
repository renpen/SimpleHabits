//
//  Alarm+CoreDataClass.swift
//  AlarmClock
//
//  Created by ReneUser on 09.11.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import Foundation
import CoreData

@objc(Alarm)
public class Alarm: NSManagedObject {
    var travel : Travel?
    var activePattern : ActivePattern?
    var wakeUpTone : AlarmSound?
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?)
    {
        super.init(entity: entity, insertInto: context)
        if self.travel_f_key == 0
        {
            self.travel = TravelCoreDataHandler.sharedInstance.fabricateTravelObject()
            let id = TravelCoreDataHandler.sharedInstance.getNewTravelID()
            self.travel_f_key = id
            self.travel?.representingCoreDataObject?.id = id
        }
        else
        {
            self.travel = TravelCoreDataHandler.sharedInstance.getTravelById(id: travel_f_key)
        }
        if self.wakeUpTone_f_key != 0
        {
            self.wakeUpTone = AlarmSoundCoreDataHandler.sharedInstance.getAlarmSoundById(id: wakeUpTone_f_key)
        }
    }
    func save()
    {
        travel?.save()
        if wakeUpTone != nil {
            wakeUpTone_f_key = (wakeUpTone?.representingCoreDataObject?.id)!
            wakeUpTone?.save()
        }
        // the context will be saved, so that the travel and the alarmobject will be saved,too
    }
    func activate()
    {
        AlarmController.sharedInstance.calculateAndSetWakeUpTime(alarm: self)
    }
}
