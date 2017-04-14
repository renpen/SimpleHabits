//
//  AlarmController.swift
//  AlarmClock
//
//  Created by ReneUser on 09.11.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import Foundation
import AVFoundation
class AlarmController {
    static let sharedInstance = AlarmController();
    var timer : Timer?
    var temp_alarm : Alarm?
    
   
    
    /*
 Falls der Alarm eine valide Wakeuptime hat geguckt ob es ein SmartAlarm ist oder nicht und dann entsprechend direkt der Timer gesetzt (bei einem StandardAlarm) oder noch weitere Berechnungen durchgeführt (tarvelTime beim SmartWecker)
 
 */
    func activate (alarm : Alarm)
    {
        if let wakeUpTime = alarm.wakeUpTime
        {
            let currentDate = Date()
            if wakeUpTime > currentDate
            {
                self.temp_alarm = alarm
                setTimer(alarm: alarm)
            }
            else
            {
                deactivate(alarm: alarm)
                if alarm.smartAlarm
                {
                        self.temp_alarm = alarm
                        alarm.travel?.calculateTravelTime(closure: prepareSmartAlarm)
                }
            }
        }
        else if alarm.smartAlarm
        {
            self.temp_alarm = alarm
            alarm.travel?.calculateTravelTime(closure: prepareSmartAlarm)
        }
    }
    private func setTimer(alarm : Alarm)
    {
        if timer != nil
        {
            self.timer?.invalidate()
        }
        print("alarm set with date: " + (alarm.wakeUpTime?.description)!)
        self.timer = Timer(fireAt: alarm.wakeUpTime!, interval: 0, target: self, selector: #selector(playSound),userInfo: nil, repeats: false)
        RunLoop.main.add(self.timer!, forMode: RunLoopMode.commonModes)

    }
    func deactivate(alarm: Alarm)
    {
        //current design allows only one active alarm, so the deactivation doesn´t need to be realted to the alarm. Maybe in future we want to use more than one alarm at a time and then the alarm needed to as parameter to decide which alarm needed to be turned off
        if self.timer != nil
        {
            self.timer?.invalidate()
            alarm.wakeUpTime = nil
            alarm.save()
        }
    }
    func getActivatedAlarmDate() -> Date?
    {
        if timer == nil
        {
            return nil
        }
        return (self.timer?.fireDate)!
    }
    private func prepareSmartAlarm(travelTime : Int)
    {
        let alarm = temp_alarm
        var travelTime = travelTime
        if travelTime == nil
        {
            print("Keine Traveltimeberechnet")
           travelTime = 0
        }
        print("TravelTime: " + travelTime.description)
        let calendarTools = CalendarTools.sharedInstance
        let offset = alarm?.offset
        let appointment = calendarTools.getFirstAppointmentUpToOneDayLater(calendar: calendarTools.getCalendarByIdentifier(identifier: (alarm?.calendarIdentifier)!))
        let calendarAPI = Calendar.current
        if appointment == nil
        {
            print("Kein Appointment gefunden")
            return
        }
        print("Appointment: " + (appointment?.description)!)
        var date = calendarAPI.date(byAdding: .minute, value: -(Int(offset!)), to: (appointment?.startDate)!)
        date = calendarAPI.date(byAdding: .second, value: -(travelTime), to: date!)
        alarm?.wakeUpTime = date!
        alarm?.save()
        setTimer(alarm: alarm!)
    }
    @objc func playSound()
    {
        print("Sound abspielen")
        print(temp_alarm?.description)
        print(temp_alarm?.wakeUpTone?.fileName)
        temp_alarm?.wakeUpTone?.playSound()
    }
    
}
