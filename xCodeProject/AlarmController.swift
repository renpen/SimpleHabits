//
//  AlarmController.swift
//  AlarmClock
//
//  Created by ReneUser on 09.11.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import Foundation
import AVFoundation
var player: AVAudioPlayer?
class AlarmController {
    static let sharedInstance = AlarmController();
    var timer : Timer?
    var temp_alarm : Alarm?
    private func setWakeUpTime(alarm: Alarm)
    {
        if timer != nil
        {
            self.timer?.invalidate()
        }
        print("alarm set with date: " + alarm.wakeUpTime.description)
        self.timer = Timer(fireAt: alarm.wakeUpTime, interval: 0, target: self, selector: #selector(playSound),userInfo: nil, repeats: false)
        RunLoop.main.add(self.timer!, forMode: RunLoopMode.commonModes)
    }
    func deactivate(alarm: Alarm)
    {
        //current design allows only one active alarm, so the deactivation doesn´t need to be realted to the alarm. Maybe in future we want to use more than one alarm at a time and then the alarm needed to as parameter to decide which alarm needed to be turned off
        if self.timer != nil
        {
            self.timer?.invalidate()
            alarm.wakeUpTime = Date(timeIntervalSince1970: 0)
            alarm.save()
        }
    }
    func reactivate(alarm : Alarm) {
        if !alarm.wakeUpTime.description.isEmpty
        {
            let currentDate = Date()
            if alarm.wakeUpTime > currentDate
            {
                if timer?.fireDate != alarm.wakeUpTime
                {
                    calculateAndSetWakeUpTime(alarm: alarm)
                }
            }
            else
            {
                deactivate(alarm: alarm)
            }
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
    func calculateAndSetWakeUpTime(alarm:Alarm)
    {
        self.temp_alarm = alarm;
        if alarm.smartAlarm
        {
            alarm.travel?.calculateTravelTime(closure: prepareSmartAlarm)
        }
        else
        {
            setWakeUpTime(alarm: alarm)
        }
        
    }
    private func prepareSmartAlarm(travelTime : Int)
    {
        print("TravelTime: " + travelTime.description)
        let alarm = temp_alarm
        let calendarTools = CalendarTools.sharedInstance
        let offset = alarm?.offset
        let appointment = calendarTools.getFirstAppointmentUpToOneDayLater(calendar: calendarTools.getCalendarByIdentifier(identifier: (alarm?.calendarIdentifier)!))
        let calendarAPI = Calendar.current
        print("Appointment: " + (appointment?.description)!)
        var date = calendarAPI.date(byAdding: .minute, value: -(Int(offset!)), to: (appointment?.startDate)!)
        date = calendarAPI.date(byAdding: .second, value: -(travelTime), to: date!)
        alarm?.wakeUpTime = date!
        alarm?.save()
        setWakeUpTime(alarm: alarm!)
    }
    @objc func playSound()
    {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch _ {
            return print("error")
        }
        print("test");
            let url = Bundle.main.url(forResource: "bell", withExtension: "mp3")!
            do {
                player = try AVAudioPlayer(contentsOf: url)
                guard let player = player else { return }
                player.prepareToPlay()
                player.play()
            } catch let error {
                print("Play ERROR")
                print(error.localizedDescription)
            }
    }
    
}
