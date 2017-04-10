//
//  AlarmCoreDataHandler.swift
//  AlarmClock
//
//  Created by René Penkert on 10.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import Foundation

class AlarmCoreDataHandler : CoreDataHandler
{
    static let sharedInstance = AlarmCoreDataHandler()
    let smartAlarmName = "SmartAlarm"
    let standardAlarm = "StandardAlarm"
    func getSmartAlarm() -> Alarm {
        var alarm = getAlarmByName(name: self.smartAlarmName)
        if alarm == nil
        {
            alarm = self.fabricateCoreDataObject(entityName: "Alarm") as! Alarm
            alarm?.name = self.smartAlarmName;
            alarm?.save()
        }
        return alarm!
    }
    func getStandardAlarm() -> Alarm {
        var alarm = getAlarmByName(name: self.standardAlarm)
        if alarm == nil
        {
            alarm = self.fabricateCoreDataObject(entityName: "Alarm") as! Alarm
            alarm?.name = self.standardAlarm;
            alarm?.save()
        }
        return alarm!
    }
    
    
    //This is private because the current design only allows a smart and a not smart Alarm. To make the API Usage more easy there are two methods to get the smart or standardalarm. When we want more than two alarms just switch the private method to a normal method and use this api to get Alarms
    private func getAlarmByName(name:String) -> Alarm?
    {
        let pred = NSPredicate(format: "(name = %@)", name)
        var objects = getObjects(entityName: "Alarm", predicate: pred)
        if (objects?.count != 0) {
            return objects?[0] as? Alarm
        }
        return nil
    }
    private func getAllAlarms() -> [Alarm]
    {
        let alarms = getObjects(entityName: "Alarm")
        if (alarms == nil) {
            return []
        }
        return (alarms as? [Alarm])!

    }
    private func deleteAlarn(alarmName: String) {
        let alarm = getAlarmByName(name: alarmName)
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


}
