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
    var wakeUpTone : AlarmSound?
    var timer : Timer?
    
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
        self.isActivated = true;
        self.save()
        if smartAlarm {
            self.travel?.calculateTravelTime(closure: prepareSmartAlarm)
        }
        else
        {
            validateWakeUpTime()
            setTimer();
        }
    }
    func deactivate()
    {
            self.timer?.invalidate()
            self.isActivated = false
        save();
    }
    func setTimer()
    {
        if timer != nil
        {
            self.timer?.invalidate()
        }
        print("alarm set with date: " + (self.wakeUpTime?.description)!)
        self.timer = Timer(fireAt: self.wakeUpTime!, interval: 0, target: self, selector: #selector(playSound),userInfo: nil, repeats: false)
        RunLoop.main.add(self.timer!, forMode: RunLoopMode.commonModes)
        
    }
    private func prepareSmartAlarm(travelTime : Int)
    {
        var travelTime = travelTime
        if travelTime == nil
        {
            print("Keine Traveltimeberechnet")
            travelTime = 0
        }
        print("TravelTime: " + travelTime.description)
        let calendarTools = CalendarTools.sharedInstance
        let offset = self.offset
        let appointment = calendarTools.getFirstAppointmentUpToOneDayLater(calendar: calendarTools.getCalendarByIdentifier(identifier: (self.calendarIdentifier)))
        let calendarAPI = Calendar.current
        if appointment == nil
        {
            print("Kein Appointment gefunden")
            return
        }
        print("Appointment: " + (appointment?.description)!)
        var date = calendarAPI.date(byAdding: .minute, value: -(Int(offset)), to: (appointment?.startDate)!)
        date = calendarAPI.date(byAdding: .second, value: -(travelTime), to: date!)
        wakeUpTime = date!
        save()
        self.setTimer()
    }

    
    @objc func playSound()
    {
        print("Sound abspielen")
        print(self.description)
        print(self.wakeUpTone?.fileName)
        self.wakeUpTone?.playSound()
    }
    
    func validateWakeUpTime() {
        //falls die wakeUpTime schon abgelaufen ist
        if (wakeUpTime! < Date())
        {
            let calendarAPI = Calendar.current
            var date = calendarAPI.date(byAdding: .day, value: 1, to: wakeUpTime!)
            wakeUpTime = date!
            validateWakeUpTime()
        }
    }

}
