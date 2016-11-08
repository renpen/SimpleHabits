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
    var offset : Int      //for waking up, eating etc. // in s
    var active = ActivePattern?
    var wakeUpTime : Date?
    var wakeUpTone : AlarmSound
    var name : String
    init(travel: Travel,wakeUpTone : AlarmSound)
    {
        self.travel = travel
        self.wakeUpTone = wakeUpTone
    }
    func activateAlarm()
    {
        
    }
    func deactivateAlarm()
    {
    
    }
    func ring()  {
        
    }
    func calculateWakeUpTime() {
    }
}



