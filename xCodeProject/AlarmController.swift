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
    var temp_alarm : Alarm?
    func activate(alarm: Alarm)
    {
        print("alarm set with date: " + alarm.wakeUpTime.description)
        let timer = Timer(fireAt: alarm.wakeUpTime, interval: 0, target: self, selector: #selector(playSound),userInfo: nil, repeats: false)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
    }
    func deactivate(alarm: Alarm)
    {
        
    }
    func calculateWakeUpTime(alarm:Alarm)
    {
        self.temp_alarm = alarm;
        alarm.travel?.calculateTravelTime(closure: setWakeUpTime)
        
    }
    private func setWakeUpTime(travelTime : Int)
    {
        print("TravelTime: " + travelTime.description)
        var alarm = temp_alarm
        let calendarTools = CalendarTools.sharedInstance
        let offset = alarm?.offset
        let appointment = calendarTools.getFirstAppointmentOneDayLater(calendar: calendarTools.getCalendarByIdentifier(identifier: (alarm?.calendarIdentifier)!))
        let calendarAPI = Calendar.current
        print("Appointment: " + (appointment?.description)!)
        var date = calendarAPI.date(byAdding: .minute, value: -(Int(offset!)), to: (appointment?.startDate)!)
        date = calendarAPI.date(byAdding: .second, value: -(travelTime), to: date!)
        alarm?.wakeUpTime = date!
        activate(alarm: alarm!)
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
