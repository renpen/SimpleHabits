//
//  Alarm.swift
//  AlarmClock
//
//  Created by ReneUser on 28.10.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import Foundation

class Alarm
{
    let travel : Travel
    var active = false
    var wakeUpTime : Date
    var wakeUpTone : NSObject       //need to be determined how the Tone is designed SE technically.
    init(travel: Travel,wakeUpTime : Date,wakeUpTone : NSObject)
    {
        self.travel = travel
        self.wakeUpTime = wakeUpTime
        self.wakeUpTone = wakeUpTone
    }
    
    func addAlarmToDatabase()
    {
        
    }
    func activateAlarm()
    {
        
    }
    func deactivateAlarm()
    {
    
    }
    
}



