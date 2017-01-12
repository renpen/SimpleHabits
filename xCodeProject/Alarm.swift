//
//  Alarm+CoreDataClass.swift
//  AlarmClock
//
//  Created by ReneUser on 09.11.16.
//  Copyright © 2016 ReneUser. All rights reserved.

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
            self.travel = CoreDataHandler.sharedInstance.fabricateTravelObject()
            let id = CoreDataHandler.sharedInstance.getNewTravelID()
            self.travel_f_key = id
            self.travel?.representingCoreDataObject?.id = id
        }
        else
        {
            self.travel = CoreDataHandler.sharedInstance.getTravelById(id: travel_f_key)
        }
        
    }
    func save()
    {
        travel?.save() // the context will be saved, so that the travel and the alarmobject will be saved,too
    }
}
