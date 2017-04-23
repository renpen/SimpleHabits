//
//  AlarmCoreDataHandler.swift
//  AlarmClock
//
//  Created by René Penkert on 10.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import Foundation
import CoreData

class AlarmCoreDataHandler : CoreDataHandler
{
    static let sharedInstance = AlarmCoreDataHandler()
//    let smartAlarmName = "SmartAlarm"
//    let standardAlarm = "StandardAlarm"
//    func getSmartAlarm() -> Alarm {
//        var alarm = getAlarmByName(name: self.smartAlarmName)
//        if alarm == nil
//        {
//            alarm = self.fabricateCoreDataObject(entityName: "Alarm") as! Alarm
//            alarm?.name = self.smartAlarmName;
//            alarm?.smartAlarm = true
//            alarm?.save()
//        }
//        return alarm!
//    }
//    func getStandardAlarm() -> Alarm {
//        var alarm = getAlarmByName(name: self.standardAlarm)
//        if alarm == nil
//        {
//            alarm = self.fabricateCoreDataObject(entityName: "Alarm") as! Alarm
//            alarm?.name = self.standardAlarm;
//            alarm?.smartAlarm = false;
//            alarm?.save()
//        }
//        return alarm!
//    }
    
    
    //This is private because the current design only allows a smart and a not smart Alarm. To make the API Usage more easy there are two methods to get the smart or standardalarm. When we want more than two alarms just switch the private method to a normal method and use this api to get Alarms
    func getAlarmByID(id:Int32) -> Alarm?
    {
        let pred = NSPredicate(format: "(id = %d)", id)
        var objects = getObjects(entityName: "Alarm", predicate: pred)
        if (objects?.count != 0) {
            return objects?[0] as? Alarm
        }
        return nil
    }
    func getAllAlarms() -> [Alarm]
    {
        let alarms = getObjects(entityName: "Alarm")
        if (alarms == nil) {
            return []
        }
        return (alarms as? [Alarm])!
    }
    func deleteAlarm(alarmID: Int32) {
        let alarm = getAlarmByID(id: alarmID)
        if alarm != nil
        {
            let travelId = alarm?.travel_f_key
            deleteObject(entity: alarm!)
            let travel = TravelCoreDataHandler.sharedInstance.getTravelById(id: Int32(travelId!))
            if travel != nil {
                deleteObject(entity: travel?.representingCoreDataObject!)
            }
        }
    }
    private func getNewAlarmID () ->Int32
    {
        let entityDescription = getEntityDescirption(entityName: "Alarm")
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
            return (objects![0] as! Alarm).id + 1
        }
        return 0
    }
    func fabricateAlarm() -> Alarm {
        let alarm = self.fabricateCoreDataObject(entityName: "Alarm") as! Alarm
        alarm.id = getNewAlarmID()
        return alarm
    }
    


}
